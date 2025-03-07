import os
from typing import Dict
from utils import generate_openai, generate_anthropic, generate_together
from typing import Dict, List 
import subprocess
import re

from prompts import prompts

from Verilog_generator import VerilogGenerator
from typing import List, Dict, Optional, Any, Tuple
import time
import json
import random
import tempfile

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

class SimpleVerifier:
    """A standalone verifier that doesn't rely on ground truth comparisons."""
    
    def __init__(self):
        self.syntax_patterns = {
            "syntax_error": ["syntax error", "error:", "undefined module"],
            "size_error": ["Sized numeric constant must have a size greater than zero"],
            "sensitivity_error": ["always_comb process has no sensitivities", "found no sensitivities"],
            "wire_error": ["is declared here as wire", "Unable to bind wire/reg"],
            "module_error": ["Unknown module type"],
            "clock_error": ["Unable to bind wire/reg/memory `clk'"],
            "reset_error": ["posedge reset", "negedge reset", "posedge r)"]
        }
    
    def compile_verilog(self, code: str) -> str:
        """Compile Verilog code using iverilog and capture output."""
        
        # Create temporary files
        with tempfile.NamedTemporaryFile(suffix='.sv', delete=False, mode='w') as f:
            f.write(code)
            code_path = f.name
        
        compile_output = ""
        try:
            # Run iverilog to check syntax
            result = subprocess.run(
                ["iverilog", "-g2012", "-o", "/dev/null", code_path],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                timeout=5
            )
            compile_output = result.stdout + result.stderr
        except Exception as e:
            compile_output = f"Compilation error: {str(e)}"
        finally:
            # Clean up temporary file
            if os.path.exists(code_path):
                os.remove(code_path)
        
        return compile_output
    
    def analyze_code(self, code: str) -> List[str]:
        """Analyze code structure without compilation."""
        issues = []
        
        # Check module definition
        if "module" not in code:
            issues.append("Missing module definition")
        
        # Check for proper use of logic vs wire/reg
        if "wire" in code or "reg" in code:
            issues.append("Use 'logic' type instead of 'wire' or 'reg'")
        
        # Check always blocks
        if "always @" in code and "always @(*)" not in code:
            issues.append("Use always @(*) for combinational logic")
        
        # Check numeric constants
        if "'b0" not in code and "'b1" not in code and ("0" in code or "1" in code):
            issues.append("Numeric constants should have explicit size (e.g., 1'b0 not 0)")
        
        # Check reset handling
        if "posedge reset" in code or "negedge reset" in code:
            issues.append("Reset signal should be sampled with the clock")
        
        return issues
    
    def generate_testbench(self, code: str) -> str:
        """Generate a simple testbench for the given Verilog code."""
        # Extract module name and ports
        module_name, ports = self._extract_module_info(code)
        
        if not module_name:
            return ""
        
        inputs = [p for p in ports if p['dir'] == 'input']
        outputs = [p for p in ports if p['dir'] == 'output']
        
        # Check if clock and reset are present
        has_clk = any(p['name'] == 'clk' for p in inputs)
        has_reset = any(p['name'] == 'reset' or p['name'] == 'rst' for p in inputs)
        
        # Create the testbench
        tb = f"`timescale 1ns/1ps\n\n"
        tb += f"module {module_name}_tb;\n\n"
        
        # Declare signals
        for port in ports:
            width_str = f"[{port['width']-1}:0]" if port['width'] > 1 else ""
            tb += f"    logic {width_str} {port['name']};\n"
        
        tb += f"\n    // Stats for tracking errors\n"
        tb += f"    typedef struct packed {{\n"
        tb += f"        int errors;        // Total error count\n"
        tb += f"        int errortime;     // Time of first error\n"
        tb += f"        int clocks;        // Total clock cycles\n"
        tb += f"    }} stats;\n\n"
        tb += f"    stats stats1 = '{{0, 0, 0}};\n\n"
        
        # Instantiate the module under test
        tb += f"    // Instantiate the Device Under Test (DUT)\n"
        tb += f"    {module_name} dut (\n"
        port_connections = [f"        .{p['name']}({p['name']})" for p in ports]
        tb += ",\n".join(port_connections)
        tb += f"\n    );\n\n"
        
        # Create clock generator if needed
        if has_clk:
            tb += f"    // Clock generator\n"
            tb += f"    localparam CLK_PERIOD = 10;\n"
            tb += f"    initial begin\n"
            tb += f"        clk = 1'b0;\n"
            tb += f"        forever #(CLK_PERIOD/2) clk = ~clk;\n"
            tb += f"    end\n\n"
        
        # Create reset generator if needed
        if has_reset:
            reset_name = next(p['name'] for p in inputs if p['name'] == 'reset' or p['name'] == 'rst')
            tb += f"    // Reset generator\n"
            tb += f"    initial begin\n"
            tb += f"        {reset_name} = 1'b1;\n"
            tb += f"        #(CLK_PERIOD * 2);\n"
            tb += f"        {reset_name} = 1'b0;\n"
            tb += f"    end\n\n"
        
        # Create test stimulus
        tb += f"    // Test stimulus\n"
        tb += f"    initial begin\n"
        tb += f"        // Initialize inputs\n"
        for port in inputs:
            if port['name'] != 'clk' and port['name'] != 'reset' and port['name'] != 'rst':
                tb += f"        {port['name']} = {port['width']}'b0;\n"
        
        tb += f"\n        // Wait for reset\n"
        if has_reset:
            tb += f"        @(negedge {reset_name});\n"
            tb += f"        #(CLK_PERIOD * 2);\n"
        else:
            tb += f"        #(CLK_PERIOD * 5);\n"
        
        # Generate test vectors
        tb += f"\n        // Test vector 1\n"
        for port in inputs:
            if port['name'] != 'clk' and port['name'] != 'reset' and port['name'] != 'rst':
                tb += f"        {port['name']} = {port['width']}'b1;\n"
        if has_clk:
            tb += f"        @(posedge clk);\n"
        else:
            tb += f"        #10;\n"
        
        tb += f"\n        // Test vector 2\n"
        for port in inputs:
            if port['name'] != 'clk' and port['name'] != 'reset' and port['name'] != 'rst':
                tb += f"        {port['name']} = {port['width']}'b0;\n"
        if has_clk:
            tb += f"        @(posedge clk);\n"
        else:
            tb += f"        #10;\n"
        
        tb += f"\n        // End simulation\n"
        tb += f"        #(CLK_PERIOD * 5);\n"
        tb += f"        $finish;\n"
        tb += f"    end\n\n"
        
        # Add output checking
        tb += f"    // Output checking\n"
        if has_clk:
            tb += f"    always @(posedge clk) begin\n"
        else:
            tb += f"    initial begin\n"
            tb += f"        // Wait for inputs to stabilize\n"
            tb += f"        #15;\n"
            tb += f"        // Monitor outputs continuously\n"
            tb += f"        forever begin\n"
        
        tb += f"        stats1.clocks = stats1.clocks + 1;\n"
        tb += f"        \n"
        tb += f"        // Check expected outputs here (placeholder)\n"
        for port in outputs:
            tb += f"        // TODO: Replace with actual expected values\n"
            tb += f"        if ({port['name']} !== {port['width']}'bx) begin\n"
            tb += f"            $display(\"Time %0t: Output %s = %h\", $time, \"{port['name']}\", {port['name']});\n"
            tb += f"        end\n"
        
        if not has_clk:
            tb += f"            #10;\n"
            tb += f"        end\n"
        
        tb += f"    end\n\n"
        
        # Add final reporting
        tb += f"    // Final reporting\n"
        tb += f"    final begin\n"
        tb += f"        $display(\"Simulation finished at %0d ps\", $time);\n"
        tb += f"        $display(\"Total clock cycles: %0d\", stats1.clocks);\n"
        tb += f"        if (stats1.errors == 0)\n"
        tb += f"            $display(\"TEST PASSED\");\n"
        tb += f"        else\n"
        tb += f"            $display(\"TEST FAILED with %0d errors\", stats1.errors);\n"
        tb += f"    end\n\n"
        
        tb += f"endmodule\n"
        
        return tb
    
    def _extract_module_info(self, code: str) -> Tuple[Optional[str], List[Dict]]:
        """Extract module name and port information from Verilog code."""
        # Extract module name
        module_match = re.search(r'module\s+(\w+)', code)
        if not module_match:
            return None, []
        
        module_name = module_match.group(1)
        
        # Extract ports
        ports = []
        # Find the module port list
        port_list_match = re.search(r'module\s+\w+\s*\(([\s\S]*?)\);', code)
        if not port_list_match:
            return module_name, ports
        
        port_text = port_list_match.group(1)
        
        # Find input and output declarations
        io_declarations = re.findall(r'(input|output)\s+(logic|wire|reg)?\s*(\[\d+:\d+\])?\s*(\w+)', port_text)
        if not io_declarations:
            io_declarations = re.findall(r'(input|output)\s+(\[\d+:\d+\])?\s*(\w+)', port_text)
            if io_declarations:
                # Adjust for missing type
                io_declarations = [(d[0], '', d[1], d[2]) if len(d) == 3 else (d[0], '', '', d[1]) for d in io_declarations]
        
        for decl in io_declarations:
            direction = decl[0]
            width_str = decl[2] if len(decl) > 2 and decl[2] else ''
            name = decl[-1]
            
            # Parse width
            width = 1
            if width_str:
                width_match = re.search(r'\[(\d+):(\d+)\]', width_str)
                if width_match:
                    width = int(width_match.group(1)) - int(width_match.group(2)) + 1
            
            ports.append({
                'name': name,
                'dir': 'input' if direction == 'input' else 'output',
                'width': width
            })
        
        return module_name, ports
    
    def run_testbench(self, code: str) -> Dict[str, Any]:
        """Generate and run a testbench for the given Verilog code."""
        # Create testbench
        testbench = self.generate_testbench(code)
        if not testbench:
            return {
                "success": False,
                "error": "Failed to generate testbench - could not extract module information"
            }
        
        # Create temporary files
        with tempfile.NamedTemporaryFile(suffix='.sv', delete=False, mode='w') as f:
            f.write(code)
            code_path = f.name
            
        with tempfile.NamedTemporaryFile(suffix='_tb.sv', delete=False, mode='w') as f:
            f.write(testbench)
            tb_path = f.name
        
        
        try:
            # Compile the code and testbench
            compile_result = subprocess.run(
                ["iverilog", "-g2012", "-o", "sim.out", code_path, tb_path],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                timeout=5
            )
            
            if compile_result.returncode != 0:
                return {
                    "success": False,
                    "error": f"Compilation failed: {compile_result.stderr}"
                }
            
            # Run the simulation
            sim_result = subprocess.run(
                ["vvp", "sim.out"],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                timeout=5
            )
            
            # Process results
            output = sim_result.stdout
            passed = "TEST PASSED" in output
            
            return {
                "success": True,
                "passed": passed,
                "output": output,
                "testbench": testbench
            }
            
        except Exception as e:
            return {
                "success": False,
                "error": f"Error running simulation: {str(e)}"
            }
        finally:
            # Clean up
            if os.path.exists(code_path):
                os.remove(code_path)
            if os.path.exists(tb_path):
                os.remove(tb_path)
            if os.path.exists("sim.out"):
                os.remove("sim.out")
    
    def verify(self, code: str) -> Dict[str, Any]:
        """Verify the code and return issues found."""
        # First analyze code structure
        static_issues = self.analyze_code(code)
        
        # Then try to compile
        compile_output = self.compile_verilog(code)
        
        # Analyze compile output for known issues
        compile_issues = []
        for issue_type, patterns in self.syntax_patterns.items():
            for pattern in patterns:
                if pattern in compile_output:
                    compile_issues.append(f"{issue_type}: {pattern}")
                    break
        
        # Combine all issues
        all_issues = static_issues + compile_issues
        
        # If there are no compilation issues, try running the testbench
        testbench_results = None
        if not compile_issues:
            testbench_results = self.run_testbench(code)
        
        return {
            "has_issues": len(all_issues) > 0,
            "issues": all_issues,
            "compile_output": compile_output,
            "testbench_results": testbench_results
        }


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


    def iterative_refinement(self, base_query: str, max_iterations: int = 5) -> Dict[str, Any]:
        """Implement iterative refinement for Verilog code generation.
        
        Args:
            base_query: The original specification to generate code for
            max_iterations: Maximum number of refinement iterations
            
        Returns:
            Dict containing the final code, test results, and iteration history
        """
        
        # Generate initial code using the existing generator
        initial_code = self.generator.generate(
            base_query,
            include_rules=True,
            include_examples=False
        )
        
        # Initialize the simple verifier
        simple_verifier = SimpleVerifier()
        
        # Keep track of iterations and improvements
        iterations = 0
        best_code = initial_code
        all_iterations = [{
            "iteration": iterations,
            "code": best_code,
            "issues": []
        }]
        
        # Iterative refinement loop
        while iterations < max_iterations:
            # Verify current code
            verification_results = simple_verifier.verify(best_code)
            
            # If no issues found, we're done
            if not verification_results["has_issues"]:
                print(f"No issues found after {iterations} iterations. Early exit.")
                break
            
            # Record issues for this iteration
            all_iterations[-1]["issues"] = verification_results["issues"]
            print(f"Iteration {iterations}: Found {len(verification_results['issues'])} issues")
            
            # Include testbench results if available
            testbench_info = ""
            if verification_results.get("testbench_results") and verification_results["testbench_results"].get("success"):
                tb_results = verification_results["testbench_results"]
                testbench_info = f"""
                TESTBENCH OUTPUT:
                {tb_results.get('output', 'No output')}

                The testbench {'PASSED' if tb_results.get('passed', False) else 'FAILED'}.
                """
            
            # Create refinement prompt with detailed feedback
            refinement_prompt = f"""
            I need you to refine the following Verilog/SystemVerilog code to fix these issues:

            ISSUES:
            {chr(10).join(verification_results["issues"])}

            COMPILER OUTPUT:
            {verification_results["compile_output"]}
            {testbench_info}
            CURRENT CODE:
            ```verilog
            {best_code}
            ```

            ORIGINAL SPECIFICATION:
            {base_query}

            Please provide an improved version of the code that addresses these issues. 
            Follow these Verilog coding guidelines:
            1. Use 'logic' type instead of 'wire' or 'reg'
            2. Use always @(*) for combinational logic
            3. Numeric constants must have size (e.g., 1'b0 not 0)
            4. Always blocks must read at least one signal
            5. For reset, use synchronous reset (sampled with clock)

            Return the improved code within [BEGIN] and [DONE] tags without any explanations.
            """
            
            # Generate refined code using the appropriate model
            refined_text = self.generator.generate_with_system_prompt(
                prompt=refinement_prompt,
                system_prompt="You are a Verilog expert that helps refine and fix issues in RTL code. You focus only on the issues presented and don't make unnecessary changes.",
                model=self.iter_ref_model,
                temperature=self.iter_ref_temp
            )
            
            # Extract code from response using the extract_between_tags function
            refined_code = extract_between_tags(refined_text, "BEGIN")
            if refined_code == refined_text:  # If tags not found, use the whole text
                refined_code = refined_text
            
            # Update best code
            best_code = refined_code
            
            # Increment iteration counter
            iterations += 1
            
            # Record this iteration
            all_iterations.append({
                "iteration": iterations,
                "code": refined_code,
                "issues": []  # Will be filled in next iteration if needed
            })
            
            print(f"Completed iteration {iterations}")
        
        # Final verification
        final_verification = simple_verifier.verify(best_code)
        
        # Update the final iteration with verification results
        if all_iterations:
            all_iterations[-1]["issues"] = final_verification["issues"]
        
        # Include testbench results in the final output
        testbench_data = {}
        if final_verification.get("testbench_results") and final_verification["testbench_results"].get("success"):
            tb_results = final_verification["testbench_results"]
            testbench_data = {
                "passed": tb_results.get("passed", False),
                "output": tb_results.get("output", ""),
                "testbench": tb_results.get("testbench", "")
            }
        
        # Now run the official verifier on our best code
        verifier = Verifier(problem_name=self.problem_name)
        test_results = verifier.functional_verify(best_code, self.problem_name)
        
        return {
            "code": best_code,
            "test_results": test_results.to_dict(),
            "iterations": all_iterations,
            "refinement_count": iterations,
            "remaining_issues": final_verification["issues"] if final_verification["has_issues"] else [],
            "testbench_results": testbench_data
        }

    def run_pipeline(self, base_query: str, refinement: bool = True, enhance_spec: bool = True, iterative_refinement: bool = True, max_iterations: int = 5, decompose: bool = False) -> Dict:
        """
        INPUT:
            base_query: str - Base query to generate testbench
            base_response: str - Base response to the query
        OUTPUT:
            Dict - Contains the generated testbench code and the test results
        """
        try:

            # print("Original specification:", flush=True)
            # print(base_query, flush=True)
            # print("\n\n", flush=True)
            if enhance_spec:
                # Enhance the specification using the prompts
                enhanced_query = self.generator.generate_with_system_prompt(
                    prompt=prompts['enhance_spec_rules'].format(user_spec=base_query),
                    system_prompt=prompts['enhance_spec_system'],
                    model='gpt-4o',
                )

                base_query += f"""Here is the enhanced specification which might be useful to you:
                {extract_between_tags(enhanced_query, "ENHANCED_SPEC")}
                """
                
                # print("Enhanced query:", flush=True)
                # print(enhanced_query, flush=True)
                # print("\n\n", flush=True)
                # print("Enhanced specification:", flush=True)
                # print(base_query, flush=True)
                # print("\n\n", flush=True)
                
            if decompose:
                print("Decomposing the problem into subtasks...")
                decomposition_result = self.decompose_and_implement(base_query)
        

                implementation_hints = "\n\n".join([
                    f"SUBTASK {impl['id']}: {impl['content']}\nIMPLEMENTATION:\n{impl['implementation']}"
                    for impl in decomposition_result
                ])
                
                base_query += f"""
                Further, I have broken down this specification into subtasks and tried implementing each one separately.
                THESE MIGHT BE INCORRECT BUT IF YOU WANT, you can use these implementations as hints to create a complete, integrated Verilog module:
                {implementation_hints}
                """

                # print("Specification after decomposition:", flush=True)
                # print(base_query, flush=True)
                # print("\n\n", flush=True)
                # print("--------------------------------", flush=True)
                # print("\n\n", flush=True)

            # Store the original specification for reference
            
            if iterative_refinement:
                #ADD CODE HERE FOR ITERATIVE REFINEMENT
                print(f"Using iterative refinement with max {max_iterations} iterations")
                result = self.iterative_refinement(base_query, max_iterations)
                return result
        
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



def decompose_and_implement(self, spec: str, model: str = "gpt-4o") -> Dict:
    """
    Decomposes the Verilog specification into subtasks, implements each subtask,
    and then uses these implementations as hints to generate the final code.
    
    INPUT:
        spec: str - The enhanced specification to decompose and implement
        model: str - The model to use for decomposition and implementation
    OUTPUT:
        Dict - Contains the decomposed subtasks and their implementations
    """
    # Step 1: Generate a plan to decompose the specification into subtasks
    
    
    # Generate the decomposition plan
    decomposition_response = self.generator.generate_with_system_prompt(
        prompt=prompts['decomposition_prompt'].format(spec=spec),
        system_prompt=prompts['decomposition_system_prompt'],
        model=model
    )
    
    
    json_match = re.search(r'```json\s*(.*?)\s*```', decomposition_response, re.DOTALL)
    if not json_match:
        print("Failed to extract JSON from decomposition response")
        return {"error": "Failed to extract JSON from decomposition response"}
    
    try:
        subtasks = json.loads(json_match.group(1))
    except json.JSONDecodeError as e:
        print(f"Failed to parse JSON: {e}")
        return {"error": f"Failed to parse JSON: {e}"}
    
    # Step 2: Implement each subtask
    implementations = []
    
    for subtask in subtasks.get("subtasks", []):
        subtask_id = subtask.get("id")
        subtask_content = subtask.get("content")
        subtask_source = subtask.get("source")
        
        
        # Generate the implementation
        implementation_response = self.generator.generate_with_system_prompt(
            prompt=prompts['implementation_prompt'].format(subtask_content=subtask_content, subtask_source=subtask_source, spec=spec),
            system_prompt=prompts['implementation_system_prompt'],
            model=model
        )
        
        # Extract the code from the response
        code_match = re.search(r'\[BEGIN\](.*?)\[DONE\]', implementation_response, re.DOTALL)
        implementation_code = code_match.group(1).strip() if code_match else implementation_response
        
        implementations.append({
            "id": subtask_id,
            "content": subtask_content,
            "source": subtask_source,
            "implementation": implementation_code
        })
    
    return implementations