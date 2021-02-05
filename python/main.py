import vim

def launch():
    vim.command("let in = input('calculator>>')")
    string = vim.eval('in')
    if not string:
        return 0
    if(string[-1]=="="):
        string = string[0:len(string)-2]
    vim.command("redraw")
    print(calc(string))
    

def calc(s):
    s = s.replace(' ', '')
    stack, operation = [], '+'
    current_num = 0
    for i in range(len(s)):
        if s[i].isdigit():
            current_num = current_num * 10 + int(s[i])
        if not s[i].isdigit() or i == len(s) - 1:
            if operation == '-':
                stack.append(-current_num)
            if operation == '+':
                stack.append(current_num)
            if operation == '*':
                stack.append(stack.pop() * current_num)
            if operation == '/':
                stack.append(int(stack.pop() / current_num))
            operation = s[i]
            current_num = 0
    result = 0
    while stack:
        result += stack.pop()
    return result
