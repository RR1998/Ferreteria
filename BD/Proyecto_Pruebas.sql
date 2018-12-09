CREATE DATABASE FERRETERIA;
USE FERRETERIA;

CREATE TABLE VENTA(
  IDVenta INT AUTO_INCREMENT NOT NULL,
  IDClienteEmpresa INT NOT NULL,
  IDVendedor INT NOT NULL,
  IDItem INT NOT NULL,
  IDDetallePago INT NOT NULL,
  Fecha DATE NOT NULL,
  UNIQUE(IDVenta)
);

CREATE TABLE DETALLEPAGO(
  IDDetalle INT AUTO_INCREMENT NOT NULL,
  MetodoPago CHAR(1) NOT NULL,
  FormaDePago CHAR(1) NOT NULL,
  Interese FLOAT(15,2) DEFAULT '0.00' NULL,
  Descuentos FLOAT(15,2) DEFAULT '0.00' NULL,
  MontoPagado FLOAT(15,2) DEFAULT '0.00' NULL,
  Cuotas INT DEFAULT '0.00' NULL,
  UNIQUE (IDDetalle)
);


CREATE TABLE EMPRESA(
  IDEmpresa INT AUTO_INCREMENT NOT NULL,
  NombreEmpresa VARCHAR(100) NOT NULL,
  NIT CHAR(17) NOT NULL,
  NumeroContribuyente INT NOT NULL,
  Email VARCHAR(100) NULL,
  Telefono CHAR(8) NOT NULL,
  UNIQUE(IDEmpresa),
  UNIQUE(NIT),
  UNIQUE(NumeroContribuyente),
  UNIQUE(Email),
  UNIQUE(Telefono)
);

CREATE TABLE PROVEEDOR(
  IDProveedor INT AUTO_INCREMENT NOT NULL,
  NombreProveedor VARCHAR(100) NOT NULL,
  DUI CHAR(10) NOT NULL,
  NIT CHAR(17) NOT NULL,
  Email VARCHAR(100) NULL,
  Telefono CHAR(8) NULL,
  IDEmpresa INT NOT NULL,
  UNIQUE(IDProveedor),
  UNIQUE(DUI),
  UNIQUE(NIT),
  UNIQUE(Email),
  UNIQUE (Telefono)
);

CREATE TABLE PRODUCTO(
  IDProducto INT AUTO_INCREMENT NOT NULL,
  NombreProducto VARCHAR(100) NOT NULL,
  Costo FLOAT(15,2) DEFAULT '0.00' NOT NULL,
  Precio FLOAT(15, 2) DEFAULT '0.00' NOT NULL,
  FechaCaducidad DATE NULL,
  IDMarca INT NOT NULL,
  IDTipo INT NOT NULL,
  UNIQUE(IDProducto)
);

CREATE TABLE TIPO(
  IDTipo INT AUTO_INCREMENT NOT NULL,
  Tipo VARCHAR(50) NULL,
  IDSubArea INT NOT NULL,
  UNIQUE(IDTipo)
);

CREATE TABLE SUBAREA(
  IDSubArea INT AUTO_INCREMENT NOT NULL,
  SubArea VARCHAR(50) NULL,
  IDArea INT NOT NULL,
  UNIQUE(IDSubArea)
);

CREATE TABLE AREA(
  IDArea INT AUTO_INCREMENT NOT NULL,
  Area VARCHAR(50),
  UNIQUE(IDArea)
);

CREATE TABLE PROVEEDORXPRODUCTOXUSUARIO(
  IDProveedor INT NOT NULL,
  IDProducto INT NOT NULL,
  IDUsuario INT NOT NULL,
  Cantidad INT DEFAULT '0',
  Precio DECIMAL(15, 2) NOT NULL,
  FechaIngreso DATE NOT NULL
);

CREATE TABLE ITEM(
  IDItem INT AUTO_INCREMENT NOT NULL,
  NombreItem VARCHAR(100) NULL,
  Descripcion VARCHAR(500) NULL,
  Costo FLOAT(15,2) DEFAULT '0.00' NOT NULL,
  Precio FLOAT(15, 2) DEFAULT '0.00' NOT NULL,
  Medidas VARCHAR(50),
  IDProducto INT,
  UNIQUE(IDItem)
);

CREATE TABLE MARCA(
  IDMarca INT AUTO_INCREMENT NOT NULL,
  NombreMarca VARCHAR(100),
  UNIQUE(IDMarca)
);

CREATE TABLE SUCURSAL(
  IDSucursal INT AUTO_INCREMENT NOT NULL,
  Direccion VARCHAR(200),
  Telefono CHAR(8),
  UNIQUE (IDSucursal)
);

CREATE TABLE VENDEDOR(
  IDVendedor INT AUTO_INCREMENT NOT NULL,
  Nombre VARCHAR(100) NOT NULL,
  FechaContratacion DATE NULL,
  DUI CHAR(10) NOT NULL,
  NIT CHAR(17) NOT NULL,
  Email VARCHAR(100) NULL,
  Telefono CHAR(8) NULL,
  ROL BOOLEAN DEFAULT 0,
  IDSucursal INT NOT NULL,
  UNIQUE (IDVendedor)
);

CREATE TABLE CLIENTE(
  IDCliente INT AUTO_INCREMENT NOT NULL,
  Nombre VARCHAR(100),
  NIT CHAR(17) NULL,
  Email VARCHAR(100) NULL,
  Telefono CHAR(8) NULL,
  UNIQUE (IDCliente)
);

CREATE TABLE USUARIO(
  IDUsuario INT AUTO_INCREMENT NOT NULL,
  Username VARCHAR(10), ##QUE EL USERNAME NO TENGA MAS DE 10 CARACTERES
  Password VARCHAR(10), ##CAMBIAR PARA QUE SE HAGA POR UN HASH
  ROL CHAR(1),          ##DEFINIR LSO VALORES DE LOS ROLES
  IDClienteVendedor INT NOT NULL,
  UNIQUE (Username),
  UNIQUE (IDUsuario)
);

#Declaraciones de llaves primarias
ALTER TABLE VENTA ADD CONSTRAINT PK_Venta PRIMARY KEY (IDVenta);
ALTER TABLE DETALLEPAGO ADD CONSTRAINT PK_DetallePago PRIMARY KEY (IDDetalle);
ALTER TABLE EMPRESA ADD CONSTRAINT PK_Empresa PRIMARY KEY (IDEmpresa);
ALTER TABLE PROVEEDOR ADD CONSTRAINT PK_Proveedor PRIMARY KEY (IDProveedor);
ALTER TABLE PRODUCTO ADD CONSTRAINT PK_Producto PRIMARY KEY (IDProducto);
ALTER TABLE TIPO ADD CONSTRAINT PK_TIPO PRIMARY KEY (IDTipo);
ALTER TABLE SUBAREA ADD CONSTRAINT PK_SUBAREA PRIMARY KEY (IDSubArea);
ALTER TABLE AREA ADD CONSTRAINT PK_AREA PRIMARY KEY (IDArea);
ALTER TABLE PROVEEDORXPRODUCTOXUSUARIO ADD CONSTRAINT PK_PXPXU PRIMARY KEY (IDProducto, IDProveedor, IDUsuario); #PXPXU = PROVEEDORXPRODUCTOXUSUARIO
ALTER TABLE ITEM ADD CONSTRAINT PK_ITEM PRIMARY KEY (IDItem);
ALTER TABLE MARCA ADD CONSTRAINT PK_MARCA PRIMARY KEY (IDMarca);
ALTER TABLE SUCURSAL ADD CONSTRAINT PK_SUCURSAL PRIMARY KEY (IDSucursal);
ALTER TABLE VENDEDOR ADD CONSTRAINT PK_Vendedor PRIMARY KEY (IDVendedor);
ALTER TABLE CLIENTE ADD CONSTRAINT PK_Cliente PRIMARY KEY (IDCliente);
ALTER TABLE USUARIO ADD CONSTRAINT PK_Usuario PRIMARY KEY (IDUsuario);


#llaves foraneas
ALTER TABLE PROVEEDOR ADD FOREIGN KEY (IDEmpresa) REFERENCES EMPRESA(IDEmpresa);
ALTER TABLE VENTA ADD FOREIGN KEY (IDClienteEmpresa) REFERENCES CLIENTE(IDCliente);
ALTER TABLE VENTA ADD FOREIGN KEY (IDClienteEmpresa) REFERENCES EMPRESA(IDEmpresa);
ALTER TABLE VENTA ADD FOREIGN KEY (IDItem) REFERENCES ITEM(IDItem);
ALTER TABLE VENTA ADD FOREIGN KEY (IDVendedor) REFERENCES VENDEDOR(IDVendedor);
ALTER TABLE VENTA ADD FOREIGN KEY (IDDetallePago) REFERENCES DETALLEPAGO(IDDetalle);
ALTER TABLE PRODUCTO ADD FOREIGN KEY (IDTipo) REFERENCES TIPO(IDTipo);
ALTER TABLE PRODUCTO ADD FOREIGN KEY (IDMarca) REFERENCES MARCA(IDMarca);
ALTER TABLE TIPO ADD FOREIGN KEY (IDSubArea) REFERENCES SUBAREA(IDSubArea);
ALTER TABLE SUBAREA ADD FOREIGN KEY (IDArea) REFERENCES AREA(IDArea);
ALTER TABLE PROVEEDORXPRODUCTOXUSUARIO ADD FOREIGN KEY (IDUsuario) REFERENCES USUARIO(IDUsuario);
ALTER TABLE PROVEEDORXPRODUCTOXUSUARIO ADD FOREIGN KEY (IDProveedor) REFERENCES PROVEEDOR(IDProveedor);
ALTER TABLE PROVEEDORXPRODUCTOXUSUARIO ADD FOREIGN KEY (IDProducto) REFERENCES PRODUCTO(IDProducto);
ALTER TABLE VENDEDOR ADD FOREIGN KEY (IDSucursal) REFERENCES SUCURSAL(IDSucursal);
ALTER TABLE ITEM ADD FOREIGN KEY (IDProducto) REFERENCES PRODUCTO(IDProducto);
ALTER TABLE USUARIO ADD FOREIGN KEY (IDClienteVendedor) REFERENCES VENDEDOR(IDVendedor);
ALTER TABLE USUARIO ADD FOREIGN KEY (IDClienteVendedor) REFERENCES CLIENTE(IDCliente);