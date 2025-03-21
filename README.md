# Verilog Code Generation and Verification Framework

This framework provides automated Verilog code generation and verification using large language models. It includes specification enhancement, task decomposition, iterative refinement, and testbench generation capabilities.

## Prerequisites

- Python 3.x
- Icarus Verilog (`iverilog`) for compilation and simulation
- OpenAI API key

## Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd <repository-name>
```

2. Create and activate a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Set up your environment variables:
```bash
# Create a .env file with your API keys
touch .env
```
Add the following to your `.env`:
OPENAI_API_KEY=your_key_here


## Usage

### Basic Code Generation

```python
from verilog_model import VerilogModel

model = VerilogModel(
    gen_tb_model="gpt-4o-mini",
    iter_ref_model="gpt-4o-mini",
    generation_temp=0.7,
    iter_ref_temp=0.7,
    problem_name="your_problem_name",
    problem_dir="path/to/output"
)

# Generate and verify code
result = model.run_pipeline(
    base_query="Your Verilog specification here",
    enhance_spec=True,
    decompose=True,
    iterative_refinement=True,
    max_iterations=5
)
```


## Key Features

1. **Specification Enhancement**
   - Improves clarity of initial requirements
   - Adds missing technical details
   - Clarifies timing and reset behavior

2. **Task Decomposition**
   - Breaks down complex modules into subtasks
   - Maintains traceability to original specifications
   - Generates focused implementations

3. **Iterative Refinement**
   - Automatically detects and fixes issues
   - Verifies syntax and functionality
   - Improves code quality through multiple iterations

4. **Testbench Generation**
   - Creates comprehensive verification environments
   - Generates test vectors
   - Reports mismatches and issues

## Output Files

The framework generates several files in your specified problem directory:
- `messages.txt`: Conversation history with the model
- `generator.txt`: Generated code and responses
- `enhanced_question.txt`: Enhanced specification
- `decomposition.txt`: Task decomposition details
- `compile_log.txt`: Compilation and simulation results
