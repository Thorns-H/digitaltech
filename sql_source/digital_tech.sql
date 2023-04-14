CREATE TABLE Usuario ( -- Tabla de Usuario (Se referencia en Orden_Productos)
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Correo_Electronico VARCHAR(255) UNIQUE NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Estatus ENUM('Activo', 'Inactivo') NOT NULL DEFAULT 'Activo'
);

CREATE TABLE Producto ( -- Tabla de Productos (Se referencia en Productos_Orden, Productos_Compras)
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Marca VARCHAR(255) NOT NULL,
    Categoria ENUM('Accesorios', 'Periféricos', 'Computadoras', 'Componentes', 'Software') NOT NULL,
    Estatus ENUM('Activo', 'Inactivo') NOT NULL DEFAULT 'Activo'
    Descripcion TEXT, 
    Imagen VARCHAR(255),
    Precio FLOAT(10,2), NO NULL
);

CREATE TABLE Orden_Productos ( -- Tabla de Orden de Productos (Se referencia en Productos_Orden)
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT UNSIGNED NOT NULL,
    Fecha_Emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    Fecha_Entrega TIMESTAMP NOT NULL,
    Estatus ENUM('Pendiente', 'Entregado') NOT NULL DEFAULT 'Pendiente',
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID)
);

CREATE TABLE Productos_Orden ( -- Tabla de Productos en una Orden (Se usa para referenciar muchos productos a una orden, se referencia en Devolucion)
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ID_Orden INT UNSIGNED NOT NULL,
    ID_Producto INT UNSIGNED NOT NULL,
    Cantidad INT NOT NULL,
    FOREIGN KEY (ID_Orden) REFERENCES Orden_Productos(ID),
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID)
);

CREATE TABLE Proveedor ( -- Tabla de Proveedores (Se referencia en Productos_Compras)
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    RFC VARCHAR(255) NOT NULL,
    Telefono VARCHAR(20) NOT NULL
);

CREATE TABLE Empleado ( -- Tabla de Empleado (Se referencia en Orden_Compras)
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Correo_Electronico VARCHAR(255) UNIQUE NOT NULL,
    Cargo ENUM('Sistemas', 'Gerente', 'Empleado') NOT NULL,
    Estatus ENUM('Activo', 'Inactivo') NOT NULL DEFAULT 'Activo'
);

CREATE TABLE Orden_Compras ( -- Tabla de Orden de Compras al Inventario (Se referencia en Productos_Compras)
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ID_Empleado INT UNSIGNED NOT NULL,
    Fecha_Emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    Fecha_Entrega TIMESTAMP NOT NULL,
    Estatus ENUM('Pendiente', 'Entregado') NOT NULL
);

CREATE TABLE Productos_Compras ( -- Tabla de Productos en una Orden de Compras al Inventario (Se usa para referenciar muchos productos a una orden)
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ID_Compras INT UNSIGNED NOT NULL,
    ID_Proveedor INT UNSIGNED NOT NULL,
    ID_Producto INT UNSIGNED NOT NULL,
    Cantidad INT NOT NULL,
    FOREIGN KEY (ID_Compras) REFERENCES Orden_Compras(ID),
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor(ID),
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID)
);

CREATE TABLE Devolucion ( -- Tabla de Devoluciones (Se referencia en Productos_Devolucion)
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Estatus ENUM('Pendiente', 'Finalizado')
);

CREATE TABLE Productos_Devolucion ( -- Tabla de Productos en una Devolución (Se utiliza para referenciar muchos productos en una devolución)
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ID_Productos_Orden INT UNSIGNED NOT NULL,
    Cantidad INT NOT NULL,
    Motivo TEXT NOT NULL
);