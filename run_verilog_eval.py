#!/usr/bin/env python3
import os
import sys
import glob
import argparse
import subprocess
import multiprocessing
from pathlib import Path
import warnings
from verilog_model import VerilogModel 
from dotenv import load_dotenv
from tqdm import tqdm

from datetime import datetime
import json
import warnings
import urllib3
warnings.filterwarnings('ignore', category=urllib3.exceptions.NotOpenSSLWarning)
from multiprocessing.pool import ThreadPool  # Add this import

load_dotenv()

# Add this function to create execution directory
def create_execution_directory(num_samples, model_name,  enhance_spec, decompose,iterative_refinement):
    # Create timestamp
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    # Create execution folder name with model and refinement info
    enhance_spec_str = "_enhanced" if enhance_spec else ""
    decompose_str = "_decomposed" if decompose else ""
    refinement_str = "_refined" if iterative_refinement else ""
    exec_folder = Path("executions") / f"samples_{num_samples}_{model_name}_{enhance_spec_str}_{decompose_str}_{refinement_str}_{timestamp}"
    exec_folder.mkdir(parents=True, exist_ok=True)
    
    return exec_folder

# Suppress deprecation warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)

def check_dependencies():
    """Check and install required dependencies"""
    try:
        import langchain
        from langchain_community.callbacks.manager import get_openai_callback
        import langchain_openai
    except ImportError:
        print("Installing required packages...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-U",
                             "langchain",
                             "langchain-openai",
                             "langchain-nvidia-ai-endpoints",
                             "langchain-community"])
        print("Packages installed successfully!")

def check_openai_key():
    """Check if OPENAI_API_KEY is set"""
    if 'OPENAI_API_KEY' not in os.environ:
        print("Error: OPENAI_API_KEY environment variable is not set!")
        print("Please set it using: export OPENAI_API_KEY='your-api-key'")
        sys.exit(1)
    

def run_problem(problem_path, config, exec_folder,  enhance_spec, decompose, iterative_refinement):
    """Run evaluation for a single problem"""
    problem_name = Path(problem_path).stem.replace("_prompt", "")
    print(f"Processing {problem_name}...")
    
    problem_dir = exec_folder / f"problem_{problem_name}"
    problem_dir.mkdir(parents=True, exist_ok=True)

    try:
        # Read the base query
        with open(problem_path, 'r') as file:
            base_query = file.read()
            
        # Save the question
        with open(problem_dir / "question.txt", 'w') as f:
            f.write(base_query)

        # Initialize VerilogModel
        model = VerilogModel(
            gen_tb_model=config['model'],
            iter_ref_model=config['model'],
            generation_temp=config['temperature'],
            problem_name=problem_name,
            examples=config['examples'],
            problem_dir=problem_dir
        )
                
        # Generate and verify code using VerilogModel
        result = model.run_pipeline(base_query, enhance_spec=enhance_spec, decompose=decompose, iterative_refinement=iterative_refinement, model=config['model'])

        # Save the generated code
        with open(problem_dir / "initial_solution.sv", 'w') as f:
            f.write(result['code'])

        # Save the full result as JSON
        with open(problem_dir / "result.json", 'w') as f:
            json.dump(result, f, indent=4)

        if 'test_results' in result and result['test_results']:
            with open(problem_dir / "test_results.txt", 'w') as f:
                f.write(str(result["test_results"]))
            
            # Check the number of mismatches directly
            num_mismatch = result['test_results'].get('num_mismatch', 1)  # Default to 1 if not found
            if num_mismatch == 0 and result['test_results'].get('passfail', '?') in ['R', '.']:
                status = "success"
            else:
                status = "failure"
            with open(problem_dir / "status.txt", 'w') as f:
                f.write(status)
                f.write(f"\n\nTest Results:\n{result['test_results']}")
            
            return status == "success"

    except Exception as e:
        print(f"Error processing {problem_name}: {str(e)}")
        with open(problem_dir / "error.txt", 'w') as f:
            f.write(f"Error: {str(e)}\n")
            if hasattr(e, 'traceback'):
                f.write(f"Traceback: {e.traceback}")
        return False
        # else:

        #     gen_cmd = [
        #         str(scripts_dir / "sv-generate"),
        #         f"--model={config['model']}", 
        #         f"--examples={config['examples']}", 
        #         f"--temperature={config['temperature']}", 
        #         f"--top-p={config['top_p']}", 
        #         f"--task={config['task']}", 
        #         f"--output={out_dir}/{problem_name}.sv",
        #         problem_path
        #     ]
        #     subprocess.run(gen_cmd, check=True, capture_output=True, text=True)
        #     # Read the generated solution
        #     with open(str(out_dir / f"{problem_name}.sv"), 'r') as f:
        #         base_response = f.read().strip()

        #     # Save the initial solution
        #     with open(problem_dir / "initial_solution.sv", 'w') as f:
        #         f.write(base_response)

        #     # Run verification
        #     vvp_cmd = ["vvp", str(out_dir / problem_name)]
        #     result = subprocess.run(vvp_cmd, check=True, capture_output=True, text=True)

        #     # Save the results
        #     with open(problem_dir / "verification_result.json", 'w') as f:
        #         json.dump({"test_results": result.stdout}, f, indent=4)

        #     # Save the final status
        #     status = "success" if "Mismatches: 0 in" in result.stdout else "failure"
        #     with open(problem_dir / "status.txt", 'w') as f:
        #         f.write(status)
        #         if result.stdout:
        #             f.write(f"\n\nTest Results:\n{result.stdout}")

        #     # Check for successful functional verification
        #     if "Mismatches: 0 in" in result.stdout:
        #         print(f"Successfully processed {problem_name} (passed both syntax and functional checks)")
        #         return True
        #     else:
        #         print(f"Functional verification failed for {problem_name}")
        #         if result.stdout:
        #             print(f"Simulation output: {result.stdout}")
        #         return False
                
            
    except Exception as e:
        print(f"Error processing {problem_name}:")
        print(f"Command failed: {' '.join(e.cmd)}")
        if e.output:
            print(f"Output: {e.output}")
        if e.stderr:
            print(f"Error: {e.stderr}")

        with open(problem_dir / "error.txt", 'w') as f:
            f.write(str(e))
        return False

def parse_args():
    parser = argparse.ArgumentParser(description='Run VerilogEval with custom settings')
    parser.add_argument('--num-samples', type=int, help='Number of samples to process (default: all)')
    parser.add_argument('--task', default='spec-to-rtl', 
                       choices=['spec-to-rtl', 'code-complete-iccad2023'],
                       help='Task type (default: spec-to-rtl)')
    parser.add_argument('--model', default='gpt-4o-mini', 
                       help='Model to use (default: gpt-4o-mini)')
    parser.add_argument('--examples', type=int, default=2, 
                       choices=range(5),
                       help='Number of examples (0-4, default: 2)')
    parser.add_argument('--temperature', type=float, default=0.2,  # Changed from 0.85
                       help='Temperature (default: 0.2)')
    parser.add_argument('--top-p', type=float, default=0.1,  # Changed from 0.95
                       help='Top-p value (default: 0.1)')
    parser.add_argument('--enhance_spec', type=bool, default=False,
                       help='Enhance the Spec (default: False)')
    parser.add_argument('--iterative_refinement', type=bool, default=False,
                       help='Iterative Refinement (default: False)')
    parser.add_argument('--decompose', type=bool, default=False,
                       help='Decompose the problem into subtasks (default: False)')
    parser.add_argument('--problem-name', type=str, 
                        help='Specific problem name to process. For example: Prob001_zero_prompt')
    return parser.parse_args()


def main():
    # Check dependencies and OpenAI key
    check_dependencies()
    check_openai_key()
    
    # Parse command line arguments
    args = parse_args()
    
    # Configuration from arguments
    config = {
        "task": args.task,
        "model": args.model,
        "examples": args.examples,
        "temperature": args.temperature,
        "top_p": args.top_p
    }
    
    # Create build directory
    Path("build").mkdir(exist_ok=True)
    
    # Find all problem prompts
    dataset_dir = f"dataset_{config['task']}"


    if args.problem_name:
        problem_file = os.path.join(dataset_dir, f"{args.problem_name}_prompt.txt")
        if not os.path.exists(problem_file):
            print(f"Error: Problem file {problem_file} not found")
            sys.exit(1)
        problem_files = [problem_file]
        print(f"Processing specific problem: {args.problem_name}")
    else:
        problem_files = sorted(glob.glob(f"{dataset_dir}/*_prompt.txt"))
        
        if not problem_files:
            print(f"No problem files found in {dataset_dir}")
            sys.exit(1)
        

    # Limit number of samples if specified
    if args.problem_name:
        num_samples = 1  # Set num_samples to 1 for single problem
    else:
        # Limit number of samples if specified
        if args.num_samples:
            problem_files = problem_files[:args.num_samples]
            if args.num_samples == 1000:
                # Initialisation problem list:
                init_list = [88, 95, 98, 107, 118, 119, 120, 123, 127, 132, 133, 134, 135, 136, 137, 138, 139, 140, 144, 145, 146, 147, 148, 150]
                problem_files = [problem_files[i] for i in init_list]


            print(f"Processing {len(problem_files)} samples...")
        else:
            print(f"Processing all {len(problem_files)} samples...")

        num_samples = args.num_samples if args.num_samples else len(problem_files)
    exec_folder = create_execution_directory(num_samples, args.model, args.enhance_spec, args.decompose, args.iterative_refinement)
    
    problem_results = {}  # Dictionary to store results for each problem
    # Process problems in parallel
    with ThreadPool(10) as pool:
        # Use tqdm to wrap the pool.starmap call for progress tracking
        results = list(tqdm(
            pool.starmap(
                run_problem,
                [(f, config, exec_folder,  args.enhance_spec, args.decompose, args.iterative_refinement) for f in problem_files]
            ),
            total=len(problem_files),  # Total number of tasks
            desc="Processing problems",  # Description for the progress bar
            unit="problem"  # Unit name for each iteration
        ))
        problem_results = {Path(f).stem.replace("_prompt", ""): success 
                        for f, success in zip(problem_files, results)}

    
    # Print and store summary
    success = sum(1 for r in results if r)
    print(f"\nCompleted {success}/{len(results)} problems successfully")
    
    # Get failed problems
    failed_problems = [name for name, success in problem_results.items() if not success]
    
    if failed_problems:
        print("\nFailed problems:")
        for problem in failed_problems:
            print(f"- {problem}")
            
        # Save failed problems to file
        with open(exec_folder / "failed_problems.txt", "w") as f:
            f.write(f"Failed problems ({len(failed_problems)}/{len(results)}):\n")
            for problem in failed_problems:
                f.write(f"- {problem}\n")


if __name__ == "__main__":
    main()