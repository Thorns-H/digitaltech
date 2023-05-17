from flask import Flask, render_template, redirect, url_for, request, flash, session
import hashlib
from handlers.user import *
from handlers.employee import *
from handlers.product import *
from handlers.suppliers import *
from handlers.comments import *
from handlers.shopping_cart import *
from handlers.product_order import *
from handlers.returns import *

app = Flask(__name__)

# Ruta para la página principal
@app.route('/')
def index():
    username = session.get('username')
    products = get_products()
    return render_template('index.html', username = username, products = products)

# Ruta para la página de registro
@app.route('/register')
def register():
    return render_template('register.html')

@app.route('/register', methods = ['POST'])
def register_post():
    name = request.form['name']
    email = request.form['email']
    cellphone = request.form['phone']
    address = request.form['address']
    password = request.form['password']

    password = hashlib.md5(password.encode()).hexdigest()

    if not new_user(name, email, cellphone, address, password):
        flash('Ha ocurrido un error')
        return redirect('/register')

    return redirect('/login')

# Ruta para la página de logeo
@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login_post():
    email = request.form['email']
    password = request.form['password']

    password = hashlib.md5(password.encode()).hexdigest()

    user = get_user(email)

    if user and user[3] == password:
        session['id'] = user[0]
        session['username'] = user[1]
        session['email'] = user[2]
        session['password'] = user[3]
        session['cellphone'] = user[4]
        session['address'] = user[5]
        return redirect('/')
    else:
        error = 'Correo electrónico o contraseña incorrectos'
        return render_template('login.html', error = error)
    
# Ruta para los datos del perfil de Usuario
@app.route('/user_profile')
def user_profile():
    return render_template('user_profile.html')

@app.route('/shopping_cart')
def shopping_cart():
    id = session.get('id')
    return render_template('shopping_cart.html', products = get_shopping_cart(id))

@app.route('/delete_shopping/<int:id>', methods = ['POST'])
def delete_shopping(id):
    user_id = session.get('id')
    remove_from_cart(user_id, id)
    return redirect(url_for('shopping_cart'))

@app.route('/clear_shopping', methods = ['POST'])
def clear_shopping():
    user_id = session.get('id')
    clear_cart(user_id)
    return redirect(url_for('shopping_cart'))

@app.route('/show_orders')
def show_orders():
    id = session.get('id')
    return render_template('show_orders.html', orders = get_user_orders(id))

@app.route('/order_info/<int:id>', methods = ['POST'])
def order_info(id):
    products = get_products_from_order(id)
    total = 0

    for product in products:
        total += (product[2] * product[3])

    total = round(total, 2)

    return render_template('order_info.html', products = products, total = total)

@app.route('/return_info/<int:id>', methods = ['POST'])
def return_info(id):
    products = get_products_from_order(id)
    total = 0

    for product in products:
        total += (product[2] * product[3])

    total = round(total, 2)

    return render_template('return_info.html', products = products, total = total, order = id)

@app.route('/generate_return/<int:id>', methods=['POST'])
def generate_return(id):
    product_ids = request.form.getlist('product_id[]')
    return_quantities = request.form.getlist('return_qty[]')
    reason = request.form['motivo']
    
    products_to_update = [(int(valor1), int(valor2)) for valor1, valor2 in zip(product_ids, return_quantities)]

    create_return(session.get('id'), reason, products_to_update, id)
    
    return redirect(url_for('index'))

@app.route('/create_order', methods = ['POST'])
def create_order():
    user_id = session.get('id')
    new_order(user_id)
    return redirect(url_for('index'))

# Ruta para cerrar sessión
@app.route('/logout')
def logout():
    session.pop('id', None)
    session.pop('username', None)
    session.pop('email', None)
    session.pop('phone', None)
    session.pop('password', None)
    session.pop('address', None)

    session.pop('employee_name', None)
    session.pop('employee_job', None)
    session.pop('employee_email', None)
    return redirect(url_for('index'))

# Ruta para la página de logeo de empleados
@app.route('/employee_login')
def employee_login():
    return render_template('employee_login.html')

@app.route('/employee_login', methods = ['POST'])
def employee_login_post():
    id = request.form['employee_id']
    password = request.form['password']

    password = hashlib.md5(password.encode()).hexdigest()

    employee = get_employee(id)

    if employee and employee[2] == password:
        session['employee_name'] = employee[1]
        session['employee_job'] = employee[5]
        session['employee_email'] = employee[4]
        return redirect(url_for('workers_control_panel'))
    else:
        error = 'Código de empleado o contraseña incorrectos'
        return render_template('employee_login.html', error = error)

# Rutas de panel de control de empleados
@app.route('/workers_control_panel', methods = ['POST', 'GET'])
def workers_control_panel():

    name = session.get('employee_name')
    job = session.get('employee_job')
    email = session.get('employee_email')

    if request.method == 'GET':
        return render_template('workers_control_panel.html', name = name, job = job, email = email)

    option = request.form['option']

    if option == 'product-related':
        return redirect(url_for('crud_products'))
    elif option == 'modify-employee':
        return redirect(url_for('crud_employees'))
    elif option == 'provider_related':
        return redirect(url_for('crud_suppliers'))
    else:
        return redirect(url_for('crud_returns'))

@app.route('/crud_returns')
def crud_returns():
    returns = get_returns()
    return render_template('crud_returns.html', returns = returns)

@app.route('/accept_returns/<int:id>/<int:id_product>/<int:quantity>', methods=['POST'])
def accept_returns(id, id_product, quantity):
    accept_return(id_product, quantity, id)
    return redirect(url_for('crud_returns'))

# Rutas de CRUD de Productos
@app.route('/crud_products')
def crud_products():
    return render_template('crud_products.html', products = [])

@app.route('/crud_products', methods=['POST'])
def add_product():
    name = request.form['nombre']
    brand = request.form['marca']
    category = request.form['categoria']
    status = request.form['estatus']
    description = request.form['descripcion']
    image = request.form['imagen']
    price = request.form['precio']

    new_product(name, brand, category, status, description, image, price)

    return render_template('crud_products.html', products = [])

@app.route('/search_products', methods=['POST'])
def search_products():

    coincidencia = request.form['coincidencia']
    products = get_products()
    filtered_products = []

    if coincidencia == '':
        return render_template('crud_products.html', products = filtered_products)

    for product in products:
        for element in product:
            if coincidencia.lower() in str(element).lower() and product not in filtered_products:
                filtered_products.append(product)

    return render_template('crud_products.html', products = filtered_products)

@app.route('/edit_product/<int:id>')
def edit_product(id):
    product = get_product(id)
    return render_template('edit_product.html', product = product)

@app.route('/product_detail/<int:id>')
def product_detail(id):
    username = session.get('username')
    product = get_product(id)
    comments = get_comments(id)
    user_id = session.get('id')

    return render_template('product_detail.html', user_id = user_id, username = username, product = product, comments = comments)

@app.route('/add_product_to_cart/<int:id>', methods = ['POST'])
def add_product_to_cart(id):
    user_id = session.get('id')
    quantity = request.form['cantidad']
    add_to_cart(user_id, id, quantity)

    return redirect(url_for('index'))

@app.route('/add_comment/<int:id>', methods = ['POST'])
def add_comment(id):
    comment = request.form['comment']
    user_id = session.get('id')

    create_comment(id, user_id, comment)

    username = session.get('username')
    product = get_product(id)

    comments = get_comments(id)

    return render_template('product_detail.html', user_id = user_id, username = username, product = product, comments = comments)

@app.route('/delete_comment/<int:id>/<int:id_product>', methods = ['POST'])
def delete_comment(id, id_product):

    remove_comment(id)

    username = session.get('username')
    user_id = session.get('id')
    product = get_product(id_product)
    comments = get_comments(id_product)

    return render_template('product_detail.html', user_id = user_id, username = username, product = product, comments = comments)

@app.route('/update_product', methods = ['POST'])
def update_products():

    identifier = request.form['id']
    name = request.form['nombre']
    brand = request.form['marca']
    category = request.form['categoria']
    status = request.form['estatus']
    description = request.form['descripcion']
    image = request.form['imagen']
    price = request.form['precio']

    update_product(identifier, name, brand, category, status, description, image, price)

    return redirect(url_for('crud_products'))

@app.route('/remove_product/<int:id>')
def remove_products(id):
    remove_product(id)
    return redirect(url_for('crud_products'))

# Rutas de CRUD de Empleados
@app.route('/crud_employees')
def crud_employees():
    return render_template('crud_employees.html', employees = [])

@app.route('/crud_employees', methods = ['POST'])
def add_employee():
    name = request.form['nombre']
    address = request.form['direccion']
    email = request.form['correo']
    job = request.form['option']

    new_employee(name, address, email, job)

    return render_template('crud_employees.html', employees = [])

@app.route('/search_employees', methods=['POST'])
def search_employees():

    coincidencia = request.form['coincidencia']
    employees = get_employees()
    filtered_employees = []

    if coincidencia == '':
        return render_template('crud_employees.html', employees = filtered_employees)

    for employee in employees:
        for element in employee:
            if coincidencia.lower() in str(element).lower() and employee not in filtered_employees:
                filtered_employees.append(employee)

    return render_template('crud_employees.html', employees = filtered_employees)

@app.route('/edit_employee/<int:id>')
def edit_employee(id):
    employee = get_employee(id)
    return render_template('edit_employee.html', employee = employee)

@app.route('/update_employee', methods = ['POST'])
def update_employees():

    identifier = request.form['id']
    name = request.form['nombre']
    address = request.form['direccion']
    email = request.form['correo']
    job = request.form['cargo']
    
    update_employee(identifier, name, address, email, job)

    return redirect(url_for('crud_employees'))

@app.route('/remove_employee/<int:id>')
def remove_employees(id):
    remove_employee(id)
    return redirect(url_for('crud_employees'))

# Rutas de CRUD de Proveedores
@app.route('/crud_suppliers')
def crud_suppliers():
    return render_template('crud_suppliers.html', suppliers = [])

@app.route('/crud_suppliers', methods=['POST'])
def add_supplier():
    name = request.form['nombre']
    address = request.form['direccion']
    rfc = request.form['rfc']
    phone = request.form['telefono']

    new_supplier(name, address, rfc, phone)

    return render_template('crud_suppliers.html', suppliers = [])

@app.route('/search_suppliers', methods=['POST'])
def search_suppliers():

    coincidencia = request.form['coincidencia']
    suppliers = get_suppliers()
    filtered_suppliers = []

    if coincidencia == '':
        return render_template('crud_suppliers.html', suppliers = [])

    for supplier in suppliers:
        for element in supplier:
            if coincidencia.lower() in str(element).lower() and supplier not in filtered_suppliers:
                filtered_suppliers.append(supplier)

    return render_template('crud_suppliers.html', suppliers = filtered_suppliers)

@app.route('/edit_supplier/<int:id>')
def edit_supplier(id):
    supplier = get_supplier(id)
    return render_template('edit_supplier.html', supplier = supplier)

@app.route('/update_supplier', methods = ['POST'])
def update_suppliers():

    identifier = request.form['id']
    name = request.form['nombre']
    address = request.form['direccion']
    rfc = request.form['rfc']
    phone = request.form['telefono']
    
    update_supplier(identifier, name, address, rfc, phone)

    return redirect(url_for('crud_suppliers'))

if __name__ == '__main__':
    app.secret_key = '192b9bdd22ab9ed4d12e236c78afcb9a393ec15f71bbf5dc987d54727823bcbf'
    app.run()