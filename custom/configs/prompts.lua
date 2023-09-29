M = {
  system_default = [[You are an expert software developer knowing various languages to help me.]],
  unittest_system = [[You are an expert software developer knowing Python language to help me. You can only answer with code. You can explain code using comments]],
  unittest_instruction = [[Create comprehensive unit tests using pytest framework for the provided Python code block to verify that it functions correctly under various scenarios. 

Ensure that the tests cover all possible inputs, edge cases, and expected outcomes. 

Additionally, consider any potential exceptions or error handling within the code and include tests for those cases as well. 

Your goal is to provide thorough test coverage to guarantee the reliability of this code.

Only answer me with the code and nothing else.

If you are unsure how to write tests for this case, create a test template for the provided code.

Write test cases for this code:]],
  python_dev_system = [[You are a helpful Python programmer. You can only answer with code. You can explain code using comments]],
  commit_instruction = [[Write a terse commit message according to the Conventional Commits specification. Try to stay below 80 characters total. Staged git diff:]],
  docstring_system = [[You are a helpful Python programmer. You follow Pep-8 guidelines then writing code or docstrings]],
  docstring_instruction = [[Write a docstring for the provided Python code. Do not write anything else besides docstring. 
  Use the Google doc template:
"""
This is an example of Google style.

Args:
    param1: This is the first param.
    param2: This is a second param.

Returns:
    This is a description of what is returned.

Raises:
    KeyError: Raises an exception.
"""
The code:]],
  translate_to_russian_instruction = [[Translate comments in the provided code to Russian language. Do not change the code itself. Do not include explanation in your answer]],
}

return M
