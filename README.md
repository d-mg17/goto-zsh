# goto

A simple shell function to manage and navigate to custom directory mappings.

## Installation

1. Clone the repository to your local machine:

```sh
git clone https://github.com/luisya22/goto.git
```

2. Navigate into the cloned folder and source the script into your .bashrc:
```sh
cd goto
echo "source $(pwd)/goto.sh" >> ~/.bashrc
```


3. Reload your .bashrc file:
```sh
source ~/.bashrc
```

## Usage:
- Add a new mapping: `goto add <entry_name> <folder_path>`
  - You may also use `$(pwd)` if you are currently in the folder you want to add: `goto add <entry_name> $(pwd)`
- Remove a mapping: `goto remove <entry_name>`
- Update a mapping: `goto update <entry_name> <new_path>`
- List all mappings: `goto list`
- Navigate to a mapping: `goto <entry_name>`

## Autocompletion
The goto function supports autocompletion for the names of your custom mappings.

## Example
```sh
goto add projects ~/Documents/Projects/MyFavoriteProject/Inside/SuperInside
goto projects
```

This will navigate to ~/Documents/Projects/MyFavoriteProject/Inside/SuperInside.
