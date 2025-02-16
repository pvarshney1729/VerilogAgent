#!/usr/bin/env python3
import os
import sys
import glob
import argparse
import subprocess
import multiprocessing
from pathlib import Path
import warnings

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

def run_problem(problem_path, config):
    """Run evaluation for a single problem"""
    problem_name = Path(problem_path).stem.replace("_prompt", "")
    print(f"Processing {problem_name}...")
    
    # Create output directory
    out_dir = Path("build") / problem_name
    out_dir.mkdir(parents=True, exist_ok=True)
    
    # Ensure scripts directory exists and is in the correct location
    scripts_dir = Path("scripts")
    if not scripts_dir.exists():
        scripts_dir = Path("../scripts")
    if not scripts_dir.exists():
        print(f"Error: Cannot find scripts directory")
        return False
    
    try:
        # Run sv-generate (syntax generation)
        gen_cmd = [
            str(scripts_dir / "sv-generate"),
            f"--model={config['model']}", 
            f"--examples={config['examples']}", 
            f"--temperature={config['temperature']}", 
            f"--top-p={config['top_p']}", 
            f"--task={config['task']}", 
            f"--output={out_dir}/{problem_name}.sv",
            problem_path
        ]
        subprocess.run(gen_cmd, check=True, capture_output=True, text=True)
        
        # Run iverilog test with problem-specific testbench and reference
        test_cmd = [
            "iverilog",
            "-g2012",
            "-Wall",
            "-o", str(out_dir / problem_name),
            str(out_dir / f"{problem_name}.sv"),  # Generated solution
            f"dataset_{config['task']}/{problem_name}_ref.sv",  # Reference implementation
            f"dataset_{config['task']}/{problem_name}_test.sv"  # Problem-specific testbench
        ]
        subprocess.run(test_cmd, check=True, capture_output=True, text=True)
        
        # Run simulation for functional verification
        vvp_cmd = ["vvp", str(out_dir / problem_name)]
        result = subprocess.run(vvp_cmd, check=True, capture_output=True, text=True)
        
        # Check for successful functional verification
        if "Mismatches: 0 in" in result.stdout:
            print(f"Successfully processed {problem_name} (passed both syntax and functional checks)")
            return True
        else:
            print(f"Functional verification failed for {problem_name}")
            if result.stdout:
                print(f"Simulation output: {result.stdout}")
            return False
        
    except subprocess.CalledProcessError as e:
        print(f"Error processing {problem_name}:")
        print(f"Command failed: {' '.join(e.cmd)}")
        if e.output:
            print(f"Output: {e.output}")
        if e.stderr:
            print(f"Error: {e.stderr}")
        return False
    except Exception as e:
        print(f"Unexpected error processing {problem_name}: {str(e)}")
        return False
    

def parse_args():
    parser = argparse.ArgumentParser(description='Run VerilogEval with custom settings')
    parser.add_argument('--num-samples', type=int, help='Number of samples to process (default: all)')
    parser.add_argument('--task', default='spec-to-rtl', 
                       choices=['spec-to-rtl', 'code-complete-iccad2023'],
                       help='Task type (default: spec-to-rtl)')
    parser.add_argument('--model', default='gpt-4', 
                       help='Model to use (default: gpt-4)')
    parser.add_argument('--examples', type=int, default=2, 
                       choices=range(5),
                       help='Number of examples (0-4, default: 2)')
    parser.add_argument('--temperature', type=float, default=0.2,  # Changed from 0.85
                       help='Temperature (default: 0.2)')
    parser.add_argument('--top-p', type=float, default=0.9,  # Changed from 0.95
                       help='Top-p value (default: 0.9)')
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
    problem_files = sorted(glob.glob(f"{dataset_dir}/*_prompt.txt"))
    
    if not problem_files:
        print(f"No problem files found in {dataset_dir}")
        sys.exit(1)
    
    # Limit number of samples if specified
    if args.num_samples:
        problem_files = problem_files[:args.num_samples]
        print(f"Processing {len(problem_files)} samples...")
    else:
        print(f"Processing all {len(problem_files)} samples...")
    
    # Process problems in parallel
    with multiprocessing.Pool() as pool:
        results = pool.starmap(
            run_problem,
            [(f, config) for f in problem_files]
        )
    
    # Print summary
    success = sum(1 for r in results if r)
    print(f"\nCompleted {success}/{len(results)} problems successfully")

if __name__ == "__main__":
    main()