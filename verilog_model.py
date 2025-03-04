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
import random

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

class StandaloneVerifier:
    """A simple verifier that catches basic syntax errors without complex testbenches"""
    
    def __init__(self, problem_name=None):
        """Initialize the verifier"""
        self.temp_dir = os.getcwd()
        self.problem_name = problem_name
        self._compile_errors = []
        self._runtime_errors = []
        self._warnings = []
    
    def extract_module_info(self, verilog_code):
        """Extract just the module name and basic port info"""
        # Clean up comments
        code_without_comments = re.sub(r'//.*?\n|/\*.*?\*/', '', verilog_code, flags=re.DOTALL)
        
        # Extract module declaration
        module_match = re.search(r'module\s+(\w+)\s*\((.*?)\);', code_without_comments, re.DOTALL)
        if not module_match:
            return None, []
        
        module_name = module_match.group(1)
        port_text = module_match.group(2)
        
        # Basic port extraction
        ports = []
        port_lines = port_text.split('\n')
        
        port_regex = r'(input|output|inout)\s+(?:reg|wire|logic)?\s*(?:\[\d+:\d+\])?\s*(\w+)'
        
        for line in port_lines:
            port_match = re.search(port_regex, line)
            if port_match:
                direction = port_match.group(1)
                name = port_match.group(2)
                ports.append({"name": name, "direction": direction})
        
        return module_name, ports
    
    def create_test_bench(self, module_name, ports):
        """Create a minimal test bench just to check for syntax errors"""
        # Identify clock and reset signals
        has_clock = any(p["name"].lower() in ["clk", "clock"] for p in ports)
        has_reset = any(p["name"].lower() in ["reset", "rst"] for p in ports)
        
        # Generate simple port declarations
        input_declarations = []
        output_declarations = []
        port_connections = []
        
        for port in ports:
            if port["direction"] == "input":
                input_declarations.append(f"reg {port['name']} = 0;")
            else:
                output_declarations.append(f"wire {port['name']};")
            
            port_connections.append(f".{port['name']}({port['name']})")
        
        # Begin test bench with minimal content
        test_bench = f"`timescale 1ns/1ps\n\nmodule test_bench;\n\n"
        
        # Add signal declarations
        for decl in input_declarations:
            test_bench += f"    {decl}\n"
        
        for decl in output_declarations:
            test_bench += f"    {decl}\n"
        
        # Basic clock generation if needed
        if has_clock:
            clock_name = next(p["name"] for p in ports if p["name"].lower() in ["clk", "clock"])
            test_bench += f"\n    // Clock generation\n"
            test_bench += f"    always #5 {clock_name} = ~{clock_name};\n"
        
        # Simple test sequence
        test_bench += "\n    initial begin\n"
        
        # Reset sequence if needed
        if has_reset:
            reset_name = next(p["name"] for p in ports if p["name"].lower() in ["reset", "rst"])
            test_bench += f"        {reset_name} = 1;\n"
            test_bench += "        #20;\n"
            test_bench += f"        {reset_name} = 0;\n"
        
        # Simple stimulus - just toggle each input once
        for port in ports:
            if port["direction"] == "input" and port["name"].lower() not in ["clk", "clock", "reset", "rst"]:
                test_bench += f"        {port['name']} = 1;\n"
                test_bench += "        #10;\n"
                test_bench += f"        {port['name']} = 0;\n"
        
        # Finish simulation
        test_bench += "        #50;\n"
        test_bench += "        $display(\"Simulation completed successfully\");\n"
        test_bench += "        $finish;\n"
        test_bench += "    end\n\n"
        
        # Module instantiation
        test_bench += f"    {module_name} dut (\n"
        test_bench += ",\n".join(f"        {port}" for port in port_connections)
        test_bench += "\n    );\n\n"
        
        # Basic waveform dumping
        test_bench += "    initial begin\n"
        test_bench += "        $dumpfile(\"waveform.vcd\");\n"
        test_bench += "        $dumpvars(0, test_bench);\n"
        test_bench += "    end\n"
        
        test_bench += "endmodule\n"
        return test_bench
    
    def get_compile_errors(self):
        """Get list of compilation errors from last verification"""
        return self._compile_errors
    
    def get_runtime_errors(self):
        """Get list of runtime errors from last verification"""
        return self._runtime_errors
    
    def get_warnings(self):
        """Get list of warnings from last verification"""
        return self._warnings
    
    def functional_verify(self, solution, module_name=None):
        """Verify if the solution compiles and runs with minimal testing"""
        # Reset error storage
        self._compile_errors = []
        self._runtime_errors = []
        self._warnings = []
        
        # Create a new ResultRecord instance
        result_record = ResultRecord()
        
        # Extract module name and ports
        extracted_name, ports = self.extract_module_info(solution)
        if not extracted_name:
            result_record.passfail = 'M'  # Module extraction failed
            self._compile_errors.append("Could not extract module name from code")
            return result_record
        
        # Setup temporary files
        solution_path = os.path.join(self.temp_dir, "temp_top.sv")
        testbench_path = os.path.join(self.temp_dir, "temp_testbench.sv")
        compile_log_path = os.path.join(self.temp_dir, "compile_log.txt")
        
        # Clean up previous files
        for path in [solution_path, compile_log_path]:
            if os.path.exists(path):
                os.remove(path)
        
        # Write solution to file
        with open(solution_path, "w") as f:
            f.write(solution)
        
        # Generate and write test bench
        test_bench = self.create_test_bench(extracted_name, ports)
        with open(testbench_path, "w") as f:
            f.write(test_bench)
        
        # Compile with Icarus Verilog
        with open(compile_log_path, "w") as log_file:
            try:
                subprocess.run(
                    ["iverilog", "-g2012", "-o", "temp_top", testbench_path, solution_path],
                    stdout=log_file,
                    stderr=subprocess.STDOUT,
                    text=True,
                    timeout=10
                )
            except Exception as e:
                result_record.passfail = 'C'
                self._compile_errors.append(f"Compilation failed: {str(e)}")
                return result_record
        
        # Run simulation if compilation succeeded
        if os.path.exists("temp_top"):
            with open(compile_log_path, "a") as log_file:
                try:
                    subprocess.run(
                        ["vvp", "temp_top"],
                        stdout=log_file,
                        stderr=subprocess.STDOUT,
                        text=True,
                        timeout=10
                    )
                except Exception as e:
                    result_record.passfail = 'R'
                    self._runtime_errors.append(f"Simulation failed: {str(e)}")
            
            if os.path.exists("temp_top"):
                os.remove("temp_top")
        
        # Process the log file for errors
        with open(compile_log_path, "r") as f:
            log_content = f.read()
            
            # Check for various error patterns
            if "syntax error" in log_content:
                result_record.passfail = 'S'
            elif "error: This assignment requires an explicit cast" in log_content:
                result_record.passfail = 'e'
            elif "error: Sized numeric constant must have a size greater than zero" in log_content:
                result_record.passfail = '0'
            elif "warning: always_comb process has no sensitivities" in log_content or "found no sensitivities" in log_content:
                result_record.passfail = 'n'
            elif "is declared here as wire" in log_content:
                result_record.passfail = 'w'
            elif "Unknown module type" in log_content:
                result_record.passfail = 'm'
            elif "Unable to bind wire/reg/memory `clk'" in log_content:
                result_record.passfail = 'c'
            elif "Unable to bind wire/reg" in log_content:
                result_record.passfail = 'p'
            elif "TIMEOUT" in log_content:
                result_record.passfail = 'T'
            elif "error:" in log_content:
                result_record.passfail = 'C'
                
                # Extract error messages
                error_lines = [line for line in log_content.split('\n') if "error:" in line]
                self._compile_errors.extend(error_lines)
            elif "Simulation completed successfully" in log_content:
                result_record.passfail = '.'
            else:
                # Default to runtime issue if no specific error found
                result_record.passfail = 'R'
        
        # Check for reset edge sensitivity issues
        if result_record.passfail == '?':
            with open(solution_path, "r") as file:
                file_content = file.read()
                if any(pattern in file_content for pattern in ["posedge reset", "negedge reset", "posedge rst", "negedge rst"]):
                    result_record.passfail = 'r'
                else:
                    result_record.passfail = 'R'
        
        # Clean up test bench file
        if os.path.exists(testbench_path):
            os.remove(testbench_path)
        
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


    def run_pipeline(self, base_query: str, refinement: bool = False, enhance_spec: bool = True, iterative_refinement: bool = False, max_iterations: int = 2) -> Dict:
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

            # Store the original specification for reference
            original_spec = base_query
            
            if iterative_refinement:
                current_query = base_query
                current_response = ""
                standalone_verifier = StandaloneVerifier(problem_name=self.problem_name)
                original_response = None
                
                for iteration in range(max_iterations):
                    print(f"Iteration {iteration + 1}/{max_iterations}")
                    
                    # Generate Verilog code - using stronger model for first iteration
                    try:
                        current_response = self.generator.generate(
                            current_query,
                            include_rules=True,
                            include_examples=False
                        )
                        
                        # Save the original response from the first iteration
                        if iteration == 0:
                            original_response = current_response
                            
                        print("Code generation successful")
                    except Exception as e:
                        print(f"Generation error: {str(e)}")
                        # Skip this iteration if generation fails
                        continue
                    
                    # Verify the code
                    result = standalone_verifier.functional_verify(current_response)
                    print(f"Verification result: {result.passfail}")
                    
                    # If the code passes verification, we're done
                    if result.passfail == '.':
                        print("Code passed verification, stopping iterations")
                        break
                    
                    # If we've reached max iterations, we're done
                    if iteration == max_iterations - 1:
                        print("Reached maximum iterations")
                        break
                    
                    # Map error codes to descriptions for better prompting
                    error_descriptions = {
                        'S': "syntax error in the code",
                        'e': "assignment that requires an explicit cast",
                        '0': "sized numeric constant with size zero (use 1'b0 not 0)",
                        'n': "always block with no sensitivities",
                        'w': "wire declaration issue",
                        'm': "unknown module type",
                        'p': "port binding error",
                        'c': "unable to bind clock signal",
                        'T': "simulation timeout (possible infinite loop)",
                        'r': "reset signal used incorrectly with posedge/negedge",
                        'R': "general runtime issue",
                        'C': "compilation error",
                        'M': "module extraction failed"
                    }
                    
                    error_desc = error_descriptions.get(result.passfail, "unknown error")
                    
                    # Generate prompt for fixing the code - enhanced with detail
                    fix_prompt = f"""
                    I have a Verilog module with a {error_desc} issue that needs fixing.
                    
                    ORIGINAL SPECIFICATION:
                    {original_spec}
                    
                    CURRENT IMPLEMENTATION WITH ERROR:
                    [BEGIN]
                    {current_response}
                    [DONE]
                    
                    DETAILED ERROR INFORMATION:
                    - Error type: {result.passfail} - {error_desc}
                    
                    REQUIRED FIXES:
                    1. Fix the {error_desc} issue
                    2. Ensure the code still meets ALL requirements in the original specification
                    3. Maintain correct functionality as specified
                    4. Ensure port declarations match what's needed by the specification
                    5. Use proper Verilog syntax and follow best practices
                    
                    IMPORTANT: Your solution must be functionally equivalent to what was requested in the specification.
                    Do not just fix the syntax error - make sure the code works correctly.
                    
                    Mark your complete solution with [BEGIN] and [DONE] tags.
                    """
                    
                    current_query = fix_prompt
                
                print("Performing verification with ground truth")
                verifier = Verifier(problem_name=self.problem_name)
                gt_result = verifier.functional_verify(current_response, self.problem_name)
                
                # Use ground truth result if available
                final_result = gt_result

                return {
                    "code": current_response,
                    "test_results": final_result.to_dict(),
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