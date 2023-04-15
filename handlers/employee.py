import hashlib
from handlers.daba_base import get_connection

# Relacionado a la Entidad Empleado

def new_employee(name: str, address: str, email: str, job: str) -> None:
    digital_tech = get_connection()

    replace_domains = ('@gmail.com', '@outlook.com', 'hotmail.com', 'yahoo.com')

    for domain in replace_domains:
        password = email.replace(domain, '@digitaltech.com')
    
    password = hashlib.md5(password.encode()).hexdigest()
    
    with digital_tech.cursor() as cursor:
        cursor.execute("INSERT INTO Empleado(Nombre, Contrasena, Direccion, Correo_Electronico, Cargo) VALUES (%s, %s, %s, %s, %s)", (name, password, address, email, job))
    
    digital_tech.commit()
    digital_tech.close()

def get_employee(id: int) -> tuple:
    digital_tech = get_connection()
    employee: tuple

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT * FROM Empleado WHERE ID = '{id}'")
        employee = cursor.fetchone()

    digital_tech.close()
    return employee

def remove_employee(id: int) -> None:
    digital_tech = get_connection()

    with digital_tech.cursor() as cursor:
        cursor.execute(f"UPDATE Empleado SET Estatus = 'Inactivo' WHERE ID = {id}")

    digital_tech.commit()
    digital_tech.close()

def get_employees() -> list:
    digital_tech = get_connection()
    employees: list

    with digital_tech.cursor() as cursor:
        cursor.execute("SELECT ID, Nombre, Direccion, Correo_Electronico, Cargo FROM Empleado WHERE Estatus = 'Activo'")
        employees = cursor.fetchall()

    digital_tech.close()
    return employees