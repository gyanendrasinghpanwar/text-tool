import argparse

def sort_lines(file_path, by):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    if by == 'length':
        sorted_lines = sorted(lines, key=len)
    else:
        sorted_lines = sorted(lines)
    
    return sorted_lines

def search_lines(file_path, keyword):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    matching_lines = [line for line in lines if keyword in line]
    return matching_lines

def main():
    parser = argparse.ArgumentParser(description='Text Tool')
    parser.add_argument('command', choices=['sort', 'search'], help='Command to run')
    parser.add_argument('--file', required=True, help='The file to process')
    parser.add_argument('--by', choices=['alphabetically', 'length'], default='alphabetically', help='Sorting criteria')
    parser.add_argument('--keyword', help='Keyword to search for')

    args = parser.parse_args()

    if args.command == 'sort':
        sorted_lines = sort_lines(args.file, args.by)
        for line in sorted_lines:
            print(line, end='')

if __name__ == '__main__':
    main()
