
from prompts import prompts
from utils import generate_openai, generate_anthropic, generate_together
import time
from typing import List, Dict, Tuple, Optional


class GenerationStats:
    def __init__(self):
        self.prompt_tokens = 0
        self.completion_tokens = 0
        self.total_tokens = 0
        self.total_cost = 0


class VerilogGenerator:
    def __init__(self, model="gpt-3.5-turbo", temperature=0.8, top_p=0.95, examples=0, task="spec-to-rtl"):
        self.temperature = temperature
        self.top_p = top_p
        self.examples = examples
        self.task = task
        self.prompts = self._load_prompts()

        self.openai_models = [
            "gpt-4o-mini", "gpt-4o",
        ]
    
        self.togetherai_chat_models = [
            "meta/llama-3.1-8b-instruct", "meta/llama-3.1-70b-instruct",
            "meta/llama-3.1-405b-instruct", 'deepseek-ai/DeepSeek-R1'
        ]

        self.anthropic_models = [
            "claude-3-5-sonnet-latest", "claude-3-5-haiku-latest"
        ]

        self.manual_models = [
               'manual-rtl-coder', 'manual-deepseek-coder-6.7b', 'manual-deepseek-coder-33b'
           ]

        all_models = (self.openai_models + self.anthropic_models + 
                     self.togetherai_chat_models )
        if model not in all_models:
            raise ValueError(f"Unknown model {model}. Available models: {all_models}")
        
        self.model = model
        

    def _load_examples(self, task: str, num_examples: int) -> str:
        """Load examples from file for in-context learning"""
        try:
            import os
            prompt_example_prefix_filename = os.path.dirname(__file__) + \
                f"/verilog-example-prefix_{task}_{str(num_examples)}-shot.txt"
            with open(prompt_example_prefix_filename) as f:
                return f.read()
        except Exception as e:
            print(f"Error loading examples: {e}")
            return ""
    
    def _load_prompts(self):
        # Move all prompts from sv-generate to a separate config file
        # and load them here
        return prompts
    
    def _construct_prompt(self, prompt_text: str, include_rules: bool = False, include_examples: bool = False) -> str:
        """Constructs the full prompt using the same logic as sv-generate"""
        full_prompt = ""
        
        # Add system message for specific models
        if self.model in ["ai-mistral-large"]:  # from models_to_repeat_system_to_human_messages
            full_prompt = self.prompts[self.task]['system_msg'] + "\n"
            
        # Add examples if requested
        if include_examples and self.examples > 0:
            # Load examples from file (you'll need to implement this)
            example_prefix = self._load_examples(self.task, self.examples)
            full_prompt += example_prefix
            
        # Add the main prompt with proper formatting
        if self.task == "code-complete-iccad2023":
            full_prompt += self._format_code_complete_prompt(prompt_text)
        else:  # spec-to-rtl
            full_prompt += "\nQuestion:\n" + prompt_text.strip() + "\n"

            # Add generation plan
            full_prompt += """
            The following plan/guidelines might be useful for generating the correct Verilog code:
            - Ensure synchronous reset is implemented as specified.
            - Initialize all flip-flops to zero in simulation.
            - Adhere strictly to the provided interface and signal names.
            - Generate results in the specified cycle timing.
            - Infer logic correctly, especially when using Karnaugh maps.
            - Handle bitwise operations and signal broadcasting correctly.
            """
            
            if include_rules:
                full_prompt += prompts['prompt_rules_suffix']
                
            full_prompt += "\nAnswer:\n"
            full_prompt += prompts['prompt_no_explain_suffix']
            
        return full_prompt
    
    def _format_code_complete_prompt(self, prompt_text: str) -> str:
        """Format prompt for code completion task"""
        prefix = True
        prefixed_lines = []
        
        for line in prompt_text.splitlines():
            if "module TopModule" in line:
                prefixed_lines.append("")
                prefix = False
            
            if prefix:
                prefixed_lines.append("// " + line)
            else:
                prefixed_lines.append(line)
        
        return self.prompts[self.task]['prompt_prefix'] + "\n".join(prefixed_lines)
    
    def generate(self, prompt_text: str, include_rules: bool = False, include_examples: bool = False) -> str:
        """Core generation logic from sv-generate"""
        full_prompt = self._construct_prompt(prompt_text, include_rules, include_examples)
        
        messages = [
            {"role": "system", "content": self.prompts[self.task]['system_msg']},
            {"role": "user", "content": full_prompt}
        ]

        # import json
        # print("Full message: ")
        # print(json.dumps(messages, indent=4))
        
        max_retries = 5
        backoff_factor = 2
        delay = 1  # initial delay in seconds

        for attempt in range(max_retries):
            try:
                if self.model in self.openai_models:
                    response = generate_openai(model=self.model, 
                                        messages=messages,
                                        temperature=self.temperature)
                elif self.model in self.anthropic_models:
                    response = generate_anthropic(messages=messages, model=self.model, 
                                            temperature=self.temperature)
                else:  # together.ai models
                    response = generate_together(messages=messages, model=self.model, 
                                            temperature=self.temperature)
                # print(f"Raw response: {response}")  # Add this line for debugging
                break
            except Exception as e:
                if "rate_limit_error" in str(e):
                    print(f"\nERROR: Rate limit exceeded, retrying in {delay} seconds\n{type(e)}\n{e}\n")
                    time.sleep(delay)
                    delay *= backoff_factor  # Exponential backoff
                elif attempt < max_retries - 1:
                    print(f"\nERROR: LLM query failed, retrying in {delay} seconds\n{type(e)}\n{e}\n")
                    time.sleep(delay)
                else:
                    raise e
    
        
        # print("Response: ")
        # print(response)

        extracted_code = self._extract_code(response, prompt_text)

        # print("Extracted code: ")
        # print(extracted_code)
        # print(f"Extracted code: {extracted_code}")  # Debug line
        return extracted_code

    def _extract_code(self, response: str, prompt_filename: str = None) -> str:
        """Extracts code from response using the same logic as sv-generate"""
        lines = response.splitlines()
        output_lines = []
        
        if self.task == "code-complete-iccad2023":
            # First pass to check module existence
            backticks_count = 0
            module_already_exists = False
            endmodule_before_startmodule = False
            
            for line in lines:
                if line.startswith("```"):
                    backticks_count += 1
                elif line.startswith("endmodule"):
                    if not module_already_exists:
                        endmodule_before_startmodule = True
                elif line.startswith("module TopModule"):
                    module_already_exists = True
                    
            if endmodule_before_startmodule:
                module_already_exists = False
                
            # Add interface if needed
            if not module_already_exists and prompt_filename:
                if prompt_filename.endswith("_prompt.txt"):
                    ifc_filename = prompt_filename[:-11] + "_ifc.txt"
                    try:
                        with open(ifc_filename) as f:
                            output_lines.append(f.read() + "\n")
                    except Exception as e:
                        print(f"Error reading interface file: {e}")
            
            # Second pass to extract code
            found_first_backticks = False
            found_second_backticks = False
            found_module = False
            found_endmodule = False
            
            for line in lines:
                echo_line = True
                
                if line.strip().startswith("module TopModule"):
                    found_module = True
                    
                if backticks_count >= 2:
                    if (not found_first_backticks) or found_second_backticks:
                        echo_line = False
                else:
                    if found_endmodule:
                        echo_line = False
                    if module_already_exists and not found_module:
                        echo_line = False
                        
                if line.startswith("```"):
                    if not found_first_backticks:
                        found_first_backticks = True
                    else:
                        found_second_backticks = True
                    echo_line = False
                elif line.strip().startswith("endmodule"):
                    found_endmodule = True
                    
                if echo_line:
                    if self.model == "manual-rtl-coder" and line.strip().startswith("endmodule"):
                        line = line.rsplit('endmodule', 1)[0] + "\n" + "endmodule"
                    output_lines.append(line)
                    
            # Add warning comments if needed
            if backticks_count == 1 or backticks_count > 2:
                output_lines.extend(["", "// VERILOG-EVAL: abnormal backticks count", ""])
            if found_module:
                output_lines.extend(["", "// VERILOG-EVAL: errant inclusion of module definition", ""])
            if not found_endmodule:
                output_lines.extend(["", "// VERILOG-EVAL: endmodule not found", ""])
                
        else:  # spec-to-rtl
            # Try [BEGIN]/[DONE] tags first
            found_code_lines = []
            found_code_start = False
            found_code_end = False
            
            for line in lines:
                if not found_code_start:
                    if line.strip() == "[BEGIN]":
                        found_code_start = True
                    elif line.lstrip().startswith("[BEGIN]"):
                        found_code_lines.append(line.lstrip().replace("[BEGIN]", ""))
                        found_code_start = True
                elif not found_code_end:
                    if line.strip() == "[DONE]":
                        found_code_end = True
                    elif line.rstrip().endswith("[DONE]"):
                        found_code_lines.append(line.rstrip().replace("[DONE]", ""))
                        found_code_end = True
                    else:
                        found_code_lines.append(line)
                        
            if found_code_start and found_code_end:
                output_lines.extend(found_code_lines)
            else:
                # Fallback to backticks extraction
                output_lines.extend(self._extract_code_with_backticks(lines))
                output_lines.append("")
                output_lines.append("// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly")

        return "\n".join(output_lines)

    def _format_line(self, line: str) -> str:
        """Format line with special handling for manual-rtl-coder"""
        if self.model == "manual-rtl-coder" and line.strip().startswith("endmodule"):
            return line.rsplit('endmodule', 1)[0] + "\n" + "endmodule"
        return line
    
    def _extract_code_with_backticks(self, lines):
        """Helper method to extract code using backticks"""
        code_lines = []
        found_first_backticks = False
        found_second_backticks = False
        found_module = False
        found_endmodule = False
        
        for line in lines:
            echo_line = True
            
            if line.strip().startswith("module TopModule"):
                found_module = True
                
            if line.startswith("```"):
                if not found_first_backticks:
                    found_first_backticks = True
                else:
                    found_second_backticks = True
                echo_line = False
            elif line.strip().startswith("endmodule"):
                found_endmodule = True
                
            if echo_line and found_first_backticks and not found_second_backticks:
                code_lines.append(line)
                
        return code_lines


    def generate_with_system_prompt(self, prompt: str, system_prompt: Optional[str] = None, model: str = "gpt-4o-mini", temperature: float = 0.7) -> List[Dict]:
        """
        INPUT:
            prompt: str - Input prompt for generation
            system_prompt: Optional[str] - System prompt for context, defaults to a predefined prompt
            model: str - The model to use for generation
            temperature: float - Temperature setting for generation
        OUTPUT:
            response: List[Dict] - Generated response
        """
        
        # Use a default system prompt if none is provided
        if system_prompt is None:
            system_prompt = "You are an expert in formal hardware design specification."

        messages = [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": prompt}
        ]
        
        if "gpt" in model:
            response = generate_openai(messages=messages, model=model, temperature=temperature)
        elif "claude" in model:
            response = generate_anthropic(messages=messages, model=model, temperature=temperature)
        else:
            response = generate_together(messages=messages, model=model, temperature=temperature)
        
        return response