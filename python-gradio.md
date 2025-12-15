# Gradio
- generate ui interfaces programmatically

## code snippets
1. python package `gradio`
2. Interface function one `input`, function `fn` to run on input and one `output`. Number of arguments of function should match the length of input array. Similarly number of output component should match the number of return values from the function.
```python
demo = gr.Interface(
  fn=greet,
  inputs=[ gr.Textbox(label = "text"), gr.Slider(label="slider")],
  outputs=["text"],
)
```
3. start gradio server
```python
demo.launch(server_name="127.0.0.1", port="8070")
```
4. UI component classes
	1. `gr.Image`: An input type that allows the user to select or upload an image.
	2. `gr.TextBox`: An expandible text box that allows the user to type in text.
	3. `gr.HTML` 
	4. `gr.Number`
	5. `gr.Checkbox`: A checkbox that can be set to True or False.
    6. `gr.CheckboxGroup`: An input type that allows users to select multiple values from a predefined checkbox list.
    7. `gr.Dropdown`: An input type that provides a dropdown list where, by default, one value can be selected. If multiselect is set to True, then one or more values can be selected.
    8. `gr.File`: An input type that allows a user to upload a file.
    9. `gr.Radio`: An input type that forces the user to choose one value.
    10. `gr.Slider`: An input type that provides a slider where a value must be selected between a minimum and a maximum range. The value parameter defines the default value, and step provides the increment value. Setting the minimum, maximum, and step values to integers will select integer values.
    11. `gr.Label`: it used in output the classes in classification model. you can select top X classes to display, if classes are too many.