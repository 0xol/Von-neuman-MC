#ip to char translator

ip_raw = list(input("\n"))

print(ip_raw)

string = str()

for char in ip_raw:
    if char == ".":
        print("_", end="")
    else:
        print(chr(int(char) + 64), end="")