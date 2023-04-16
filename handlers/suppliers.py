from handlers.daba_base import get_connection

# Relacionado a la Entidad Proveedor

def new_supplier(name: str, address: str, rfc: str, phone: str) -> None:
    digital_tech = get_connection()

    print(name, address, rfc, phone)
    input()
    
    with digital_tech.cursor() as cursor:
        cursor.execute(f"INSERT INTO Proveedor(Nombre, Direccion, RFC, Telefono) VALUES ('{name}', '{address}', '{rfc}', '{phone}')")
    
    digital_tech.commit()
    digital_tech.close()

def get_supplier(id: int) -> tuple:
    digital_tech = get_connection()
    supplier: tuple

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT * FROM Proveedor WHERE ID = '{id}'")
        supplier = cursor.fetchone()

    digital_tech.close()
    return supplier

def get_suppliers() -> list:
    digital_tech = get_connection()
    suppliers: list

    with digital_tech.cursor() as cursor:
        cursor.execute("SELECT * FROM Proveedor")
        suppliers = cursor.fetchall()

    digital_tech.close()
    return suppliers

def update_supplier(id: str, name: str, address: str, rfc: str, phone: str):
    digital_tech = get_connection()
    
    with digital_tech.cursor() as cursor:
        cursor.execute(f"UPDATE Proveedor SET Nombre = '{name}', Direccion = '{address}', RFC = '{rfc}', Telefono = '{phone}' WHERE ID = '{id}'")

    digital_tech.commit()
    digital_tech.close()