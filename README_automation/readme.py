import os
import requests

def generate_readme(file_content):
    url = "http://localhost:11434/api/generate"
    headers = {
        "Content-Type": "application/json"
    }
    data = {
        "model": "gemini",
        "prompt": f"Generate a README documentation for the following project. The project is implemented in JavaScript and includes the following code:\n\n{file_content}",
        "stream": False
    }
    response = requests.post(url, headers=headers, json=data)
    response.raise_for_status()
    return response.json()['response']

def create_readme_from_file(input_file, output_file):
    with open(input_file, 'r') as infile:
        file_content = infile.read()
        readme_content = generate_readme(file_content)
        
        with open(output_file, 'w') as outfile:
            outfile.write(readme_content)

if __name__ == '__main__':
    input_file = 'main.js'  # Replace with your input file
    output_file = 'README.md'
    create_readme_from_file(input_file, output_file)
    print(f"README has been generated and saved to {output_file}")
