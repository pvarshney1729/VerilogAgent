import os
from typing import Dict
from utils import generate_openai, generate_anthropic, generate_together
from typing import Dict, List 
import subprocess
import re

from prompts import prompts

from Verilog_generator import VerilogGenerator
from typing import List, Dict, Optional
import time
import json

def extract_between_tags(text: str, tag: str) -> str:
    """Extract content between XML-style tags"""
    start_tag = f"<{tag}>"
    end_tag = f"</{tag}>"
    try:
        start_idx = text.find(start_tag)
        end_idx = text.find(end_tag)
        
        # Check if both tags exist before proceeding
        if start_idx == -1 or end_idx == -1:
            return text  # Return original text if tags not found
            
        start = start_idx + len(start_tag)
        return text[start:end_idx].strip()
    except Exception as e:
        print(f"Error extracting content between {tag} tags: {str(e)}")
        return text
    
    

class ResultRecord:
    def __init__(self):
        self.num_mismatch = 0
        self.passfail = '?'

    def to_dict(self):
        return {
            "num_mismatch": self.num_mismatch,
            "passfail": self.passfail
        }

class Verifier:
    def __init__(self, problem_name: str):
        ground_truth_path = "dataset_spec-to-rtl"
        self.ground_truth_path = os.path.join(os.getcwd(), ground_truth_path)

    def functional_verify(self, solution: str, ground_truth: str)->ResultRecord:
        """
        solution: str
            The solution string that needs to be verified, like: 
            "module RefModule (
                output zero
            );
                assign zero = 1'b0;
            endmodule"

        ground_truth: str
            The name of the ground truth file, like Problem001_zero, 
            We inherently assume there are two files:
                1. Problem001_zero_ref.sv
                2. Problem001_zero_test.sv
        """

        # The ground truth test_bench path
        ground_truth_test_bench_path = os.path.join(self.ground_truth_path, ground_truth + "_test.sv")

        # The ground truth reference path
        ground_truth_ref_path = os.path.join(self.ground_truth_path, ground_truth + "_ref.sv")

        # Write the solution to a temporary file
        solution_path = os.path.join(os.getcwd(), "temp_top.sv")

        if os.path.exists(solution_path):
            os.remove(solution_path)

        with open(solution_path, "w") as f:
            f.write(solution)
 
        compile_log_path = os.path.join(os.getcwd(), "compile_log.txt") 
        if os.path.exists(compile_log_path):
            os.remove(compile_log_path)

        # Compile the simulation and append the output to a compile log file
        with open(compile_log_path, "w") as log_file:
            result = subprocess.run(
                ["iverilog", "-g2012", "-o", "temp_top", ground_truth_test_bench_path, solution_path, ground_truth_ref_path],
                stdout=log_file,
                stderr=subprocess.STDOUT,  # Redirect stderr to stdout
                text=True
            )

        # Second subprocess call (if temp_top exists)
        if os.path.exists("temp_top"):
            with open(compile_log_path, "a") as log_file:
                result = subprocess.run(
                    ["vvp", "temp_top"],
                    stdout=log_file,
                    stderr=subprocess.STDOUT,  # Redirect stderr to stdout
                    text=True
                )
            os.remove("temp_top")

        with open("compile_log.txt", "r") as f:

            error_C     = False
            error_p     = False
            no_mismatch = False

            mismatch_pattern = r'^Mismatches: (\d+) in \d+ samples$'
            result_record = ResultRecord()

            for line in f:

                if "syntax error" in line:
                    result_record.passfail = 'S'
                    break

                if "error" in line:
                    error_C = True

                if "error: This assignment requires an explicit cast" in line:
                    result_record.passfail = 'e'
                    break

                if "error: Sized numeric constant must have a size greater than zero" in line:
                    result_record.passfail = '0'
                    break

                if "warning: always_comb process has no sensitivities" in line:
                    result_record.passfail = 'n'
                    break

                if "found no sensitivities so it will never trigger" in line:
                    result_record.passfail = 'n'
                    break

                if "is declared here as wire" in line:
                    result_record.passfail = 'w'
                    break

                if "Unknown module type" in line:
                    result_record.passfail = 'm'
                    break

                if "Unable to bind wire/reg" in line:
                    error_p = True

                if "Unable to bind wire/reg/memory `clk'" in line:
                    result_record.passfail = 'c'
                    break

                if "TIMEOUT" in line:
                    result_record.passfail = 'T'
                    break

                match = re.match(mismatch_pattern, line )
                if match:
                    num_mismatch = int(match.group(1))
                    if num_mismatch == 0:
                        no_mismatch = True
                    else:
                        result_record.num_mismatch = num_mismatch

                if result_record.passfail == '?' and error_p:
                    result_record.passfail = 'p'

                if result_record.passfail == '?' and error_C:
                    result_record.passfail = 'C'

                if result_record.passfail == '?' and no_mismatch:
                    result_record.passfail = '.'

            # process verilog to identify possible runtime issues

            if result_record.passfail == '?':

                with open(solution_path, "r") as file:
                    for line in file:
                        if "posedge reset" in line:
                            result_record.passfail = 'r'
                            break

                        if "negedge reset" in line:
                            result_record.passfail = 'r'
                            break

                        if "posedge r)" in line:
                            result_record.passfail = 'r'
                            break

                    if result_record.passfail == '?':
                        result_record.passfail = 'R'

        return result_record
     



class VerilogModel:
    def __init__(
        self,
        gen_tb_model: str = "gpt-4o-mini",
        iter_ref_model: str = "gpt-4o-mini",
        generation_temp: float = 0.7,
        iter_ref_temp: float = 0.7, 
        problem_name: str = None,
        examples: int = 0
    ):
        """
        INPUT:
            gen_tb_model: str - Model for generating testbench code
            iter_ref_model: str - Model for iterative refinement
            generation_temp: float - Generation temperature
            iter_ref_temp: float - Iterative refinement temperature
        """
        self.generation_temp=generation_temp
        self.iter_ref_temp=iter_ref_temp
        self.gen_tb_model=gen_tb_model
        self.iter_ref_model=iter_ref_model

        self.generator = VerilogGenerator(
            model=gen_tb_model,
            temperature=generation_temp,
            examples=examples
        )
        self.problem_name = problem_name

    def generate(self, prompt: str, model: str = "gpt-4o-mini") -> List[Dict]:
        """
        INPUT:
            prompt: str - Input prompt for generation
            model: str - The model to use for generation
        OUTPUT:
            response: str - Generated response
        """

        messages = [
            {"role": "system", "content": "You are a helpful assistant that generates responses to user queries."},
            {"role": "user", "content": prompt}
        ]
        
        if "gpt" in model:
            response = generate_openai(messages=messages, model=model, temperature=self.generation_temp)
        elif "claude" in model:
            response = generate_anthropic(messages=messages, model=model, temperature=self.generation_temp)
        else:
            response = generate_together(messages=messages, model=model, temperature=self.generation_temp)
        return response

    def gen_tb_prompt(self, base_query: str, base_response: str, model: str = "gpt-4o-mini") -> str:
        """
        INPUT:
            base_query: str - Base query to generate testbench
            base_response: str - Base response to the query
            model: str - The model to use for generation
        OUTPUT:
            str - Prompt for generating testbench code
        """
        prompt = f"""Generate a SystemVerilog testbench for the following design, adhering to these requirements:

            0. The specification with which the design code was generated: 
            {base_query}

            1. The design code to verify is:
            {base_response}
            
            """ + """
            
            2. Design Coding Rules:
            - All ports and signals must be declared as 'logic' (no wire/reg)
            - Use always @(*) for combinational logic (implicit sensitivity list)
            - Numeric constants must have size > 0 (e.g., 1'b0 not 0'b0)
            - Always blocks must read at least one signal
            - For synchronous reset designs:
            * Reset signal is sampled with the clock
            * Exclude posedge reset from sequential block sensitivity lists

            3. Testbench Requirements:
            - Implement comprehensive corner case testing
            - Include at least two test points
            - Track errors using this structure:
            typedef struct packed {
                int errors;        // Total error count
                int errortime;     // Time of first error
                int errors_zero;   // Errors for zero output
                int errortime_zero; // Time of first zero error
                int clocks;        // Total clock cycles
            } stats;

            4. Required Error Reporting:
            
            - Include this final block:
            final begin
                if (stats1.errors_zero)
                    $display("Hint: Output '%s' has %0d mismatches. The first mismatch occurred at time %0d.",
                            "zero", stats1.errors_zero, stats1.errortime_zero);
                else
                    $display("Hint: Output '%s' has no mismatches.", "zero");

                $display("Hint: Total mismatched samples is %1d out of %1d samples\n",
                        stats1.errors, stats1.clocks);
                $display("Simulation finished at %0d ps", $time);
                $display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
            end
 

            5. Testbench Structure:
            - Include clock generation with a configurable period
            - Implement reset sequence if the desing is sequential
            - Generate test vectors covering corner cases
            - Add output validation checks
            - Add simulation timeout
            - Use modular structure with separate blocks for:
                * Clock/reset generation
                * DUT instantiation
                * Stimulus generation
                * Response checking
                * Error tracking
                * Assertions
                * Results Reporting

            Please generate a complete SystemVerilog testbench following these requirements. The generated testbench, 
            should be enclosed within the tags [BEGIN] and [DONE]. Don't include any explanation, only the code.
            """

        return prompt

    def gen_tb_code(self, prompt: str, model: str = "gpt-4o-mini") -> str:
        """
        INPUT:
            prompt: str - Prompt for generating testbench code
            model: str - The model to use for generation
        OUTPUT:
            str - Generated testbench code
        """
        messages = [
            {"role": "system", "content": "You are a Verilog RTL tester that only writes code using correct Verilog syntax."},
            {"role": "user", "content": prompt}
        ]
        response = generate_openai(messages=messages, model=model, temperature=self.generation_temp)
        return response


    def run_pipeline(self, base_query: str, refinement: bool = False, enhance_spec: bool = True, iterative_refinement: bool = False, max_iterations: int = 3) -> Dict:
        """
        INPUT:
            base_query: str - Base query to generate testbench
            base_response: str - Base response to the query
        OUTPUT:
            Dict - Contains the generated testbench code and the test results
        """
        try:
            if enhance_spec:
                # Enhance the specification using the prompts
                enhanced_query = self.generator.generate_with_system_prompt(
                    prompt=prompts['enhance_spec_rules'].format(user_spec=base_query),
                    system_prompt=prompts['enhance_spec_system'],
                    model='gpt-4o',
                )
                base_query = extract_between_tags(enhanced_query, "ENHANCED_SPEC")

            if iterative_refinement:
                current_query = base_query
                current_response = ""
                
                for iteration in range(max_iterations):
                    try:
                        try:
                            generated_code = self.generator.generate(
                                current_query,
                                include_rules=True,
                                include_examples=False
                            )
                            
                            if isinstance(generated_code, list):
                                current_response = generated_code[0]  
                            else:
                                current_response = generated_code
                        except Exception as gen_error:
                            print(f"Generation error: {str(gen_error)}")
                            fallback_response = self.generator.generate_with_system_prompt(
                                prompt=current_query,
                                system_prompt="You are a code generation assistant. Generate code to solve the problem.",
                                model='gpt-4o-mini',
                            )
                            if isinstance(fallback_response, list):
                                for message in fallback_response:
                                    if message.get('role') == 'assistant':
                                        current_response = message.get('content', '')
                                        break
                                else:
                                    current_response = fallback_response[-1].get('content', '')
                            else:
                                current_response = str(fallback_response)
                        
                        verifier = Verifier(problem_name=self.problem_name)
                        test_results = verifier.functional_verify(current_response, self.problem_name)
                        
                        if iteration == max_iterations - 1:
                            break
                        
                        verif = f"""
                        Original Query: {base_query}
                        Current Response: {current_response}
                        Test Results: {test_results.to_dict()}
                        Please evaluate this response and identify:
                        1. What issues exist in the code that cause test failures?
                        2. What modifications are needed to fix these issues?
                        3. Should we make another iteration to improve the response?
                        Return your analysis in this format:
                        {{
                            "issues": "description of issues in the code",
                            "needed_fixes": ["list", "of", "needed", "fixes"],
                            "needs_iteration": true/false,
                            "follow_up_query": "refined query for next iteration with the code improvements"
                        }}
                        """
                        
                        # Use existing generate method for verification
                        verif_result = self.generator.generate_with_system_prompt(
                            prompt=verif,
                            system_prompt="You are a code reviewer. Analyze the code and test results carefully.",
                            model='gpt-4o-mini',
                        )
                        
                        try:
                            # Extract text content from the response structure
                            if isinstance(verif_result, list):
                                # Extract content from assistant's message
                                for message in verif_result:
                                    if message.get('role') == 'assistant':
                                        verification_content = message.get('content', '')
                                        break
                                else:
                                    verification_content = verif_result[-1].get('content', '')
                            else:
                                verification_content = str(verif_result)
                                
                            result = json.loads(extract_json(verification_content))
                        except Exception as json_error:
                            print(f"JSON parsing error: {str(json_error)}")
                            break
                        
                        if not result.get('needs_iteration', False):
                            break
                        
                        follow_up_result = result.get('follow_up_query')
                        if follow_up_result:
                            current_query = follow_up_result
                        else:
                            break
                            
                    except Exception as e:
                        print(f"Error in iteration {iteration + 1}: {str(e)}")
                        break
                
                verifier = Verifier(problem_name=self.problem_name)
                test_results = verifier.functional_verify(current_response, self.problem_name)
                
                return {
                    "code": current_response,
                    "test_results": test_results.to_dict(),
                    "iterations_used": iteration + 1
                }
            
            elif not refinement:
                # Original approach using sv-generate style
                generated_code = self.generator.generate(
                    base_query,
                    include_rules=True,
                    include_examples=False
                )
                verifier = Verifier(problem_name=self.problem_name)
                test_results = verifier.functional_verify(generated_code, self.problem_name)
                
                return {
                    "code": generated_code,
                    "test_results": test_results.to_dict()
                }
            else:
                # Refinement approach
                base_response = self.generator.generate(
                    base_query,
                    include_rules=True,
                    include_examples=False
                )[0]  # Get just the code, ignore stats

                # Generate testbench and verify
                verifier = Verifier(problem_name=self.problem_name)
                test_results = verifier.functional_verify(base_response, self.problem_name)
                
                return {
                    "code": base_response,
                    "test_results": test_results.to_dict()
                }
                
        except Exception as e:
            print(f"Error in run_pipeline: {str(e)}")
            raise

def extract_json(text):
    """Helper function to extract JSON from text that might contain other content"""
    import re
    json_match = re.search(r'({[\s\S]*})', text)
    if json_match:
        return json_match.group(1)
    return "{}"