from handlers.daba_base import get_connection

# Relacionado a la Entidad Usuario

def new_user(name: str, email: str, cellphone: str, address: str, password: str) -> bool:
    digital_tech = get_connection()
    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT COUNT(*) FROM Usuario WHERE Correo_Electronico = '{email}'")

    if len(cellphone) != 10 or cursor.fetchone()[0] > 0:
        digital_tech.close()
        return False
    
    with digital_tech.cursor() as cursor:
        cursor.execute("INSERT INTO Usuario(Nombre, Correo_Electronico, Telefono, Direccion, Contrasena) VALUES (%s, %s, %s, %s, %s)", (name, email, cellphone, address, password))
    
    digital_tech.commit()
    digital_tech.close()

    return True

def get_user(email: str) -> tuple:
    digital_tech = get_connection()
    user: tuple

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT ID, Nombre, Correo_Electronico, Contrasena, Telefono, Direccion FROM Usuario WHERE Correo_Electronico = '{email}'")
        user = cursor.fetchone()

    digital_tech.close()
    return user

def get_user(id: int) -> tuple:
    digital_tech = get_connection()
    user: tuple

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT ID, Nombre, Correo_Electronico, Contrasena, Telefono, Direccion FROM Usuario WHERE Correo_Electronico = '{id}'")
        user = cursor.fetchone()

    digital_tech.close()
    return user

def remove_user(id: int) -> None:
    digital_tech = get_connection()

    with digital_tech.cursor() as cursor:
        cursor.execute(f"UPDATE Usuario SET Estatus = 'Inactivo' WHERE ID = {id}")

    digital_tech.commit()
    digital_tech.close()

def get_users() -> list:
    digital_tech = get_connection()
    users: list

    with digital_tech.cursor() as cursor:
        cursor.execute("SELECT ID, Nombre, Correo_Electronico, Telefono, Direccion FROM Usuario WHERE Estatus = 'Activo'")
        users = cursor.fetchall()

    digital_tech.close()
    return users