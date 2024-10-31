print("Hello from develop branch!")

def addition(a, b):
    if isinstance(a, (int, float)) and isinstance(b, (int, float)):
        return a + b
    else:
        return "Erreur : Les paramètres doivent être des nombres"

print(addition(5, 3))
