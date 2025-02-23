import os
from typing import Dict
from utils import generate_openai, generate_anthropic, generate_together
from typing import Dict, List 
import subprocess

class ResultRecord:
    def __init__(self):
        self.num_mismatch = 0
        self.passfail = '?'

class Verifier:
    def __init__(self):
        ground_truth_path = "verilog-eval/dataset_spec-to-rtl"
        self.ground_truth_path = os.path.join(os.getcwd(), ground_truth_path)

    def functional_verify(self, design: str, testbench: str)->ResultRecord:
        """
        design: str
            The solution string that needs to be verified, like: 
            "module RefModule (
                output zero
            );
                assign zero = 1'b0;
            endmodule"

        testbench: str
            The name of the ground truth testbench str, like: "Ref
        """


        # Write the design to a temporary file
        design_path = os.path.join(os.getcwd(), "temp_top.sv")

        if os.path.exists(design_path):
            os.remove(design_path)

        with open(design_path, "w") as f:
            f.write(design)

        # Write the ground truth testbench to a temporary file
        test_bench_path = os.path.join(os.getcwd(), f"temp_test.sv")
        if os.path.exists(test_bench_path):
            os.remove(test_bench_path)

        with open(test_bench_path, "w") as f:
            f.write(testbench)

        compile_log_path = os.path.join(os.getcwd(), "compile_log.txt") 
        if os.path.exists(compile_log_path):
            os.remove(compile_log_path)

        # Compile the simulation and append the output to a compile log file
        with open(compile_log_path, "w") as log_file:
            result = subprocess.run(
                ["iverilog", "-g2012", "-o", "temp_top", design_path, test_bench_path],
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

        with open(compile_log_path, "r") as f:  
            compile_log = f.read()
            return compile_log

        """
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

        return result_record, compile_log_path
        """

class VerilogModel:
    def __init__(
        self,
        gen_tb_model: str = "gpt-4o-mini",
        iter_ref_model: str = "gpt-4o-mini",
        generation_temp: float = 0.7,
        iter_ref_temp: float = 0.7, 
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
    
    def test_verilog(self, design_code: str, testbench_code: str) -> str:
        """
        INPUT:
            design_code: str - Design code to be tested
            testbench_code: str - Testbench code to test the design code
        OUTPUT:
            str - Test results
        """

        verifier = Verifier()
        result = verifier.functional_verify(design_code, testbench_code)
        return result

    def run_pipeline(self, base_query: str, base_response: str) -> Dict:
        """
        INPUT:
            base_query: str - Base query to generate testbench
            base_response: str - Base response to the query
        OUTPUT:
            Dict - Contains the generated testbench code and the test results
        """
        # Generate testbench prompt
        tb_prompt = self.gen_tb_prompt(base_query, base_response, model=self.gen_tb_model)
        # Generate testbench code
        tb_code = self.gen_tb_code(tb_prompt, model=self.gen_tb_model)

        # Extract tb code from the response
        tb_code = tb_code.split("[BEGIN]")[1].split("[DONE]")[0].strip()

        # Test the design code with the generated testbench
        test_results = self.test_verilog(base_response, tb_code)

        return {"testbench_code": tb_code, "test_results": test_results}


    def run_pipeline(self, base_query: str, base_response: str) -> Dict:
        """
        INPUT:
            base_query: str - Base query to generate testbench
            base_response: str - Base response to the query
        OUTPUT:
            Dict - Contains the generated testbench code and the test results
        """
        # Generate testbench prompt
        tb_prompt = self.gen_tb_prompt(base_query, base_response, model=self.gen_tb_model)
        # Generate testbench code
        tb_code = self.gen_tb_code(tb_prompt, model=self.gen_tb_model)

        # Extract tb code from the response
        tb_code = tb_code.split("[BEGIN]")[1].split("[DONE]")[0].strip()

        # Test the design code with the generated testbench
        test_results = self.test_verilog(base_response, tb_code)

        return {"testbench_code": tb_code, "test_results": test_results}
