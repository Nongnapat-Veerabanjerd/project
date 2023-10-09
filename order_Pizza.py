print("Welcome to Yummy Pizza!🍕")
name_cuz = input("What is your name?: ").capitalize()
print(f"Hello {name_cuz}, I'm Zaza. Nice to meet you, sir!😊")

text = """
Let's start order!
Pizza:
[H]awaiian
[T]om Yum Kung
[P]epperoni
--------------------------------------
Crust:
Enter [P] to order: Pan
Enter [T] to order: Crispy Thin
Enter [C] to order: Extreme Cheese
--------------------------------------
Size:
Enter [M] to order: Size M
Enter [L] to order: Size L
--------------------------------------
Enter [x] to end the order❌
"""
print(text)

def order_pizza():
    total = 0
    menus = {
        "H": {"name_pizza": "Hawaiian", 
              "crust": {"p":{"name_crust": "Pan", "size":{"M": 379, "L": 499}}, 
                        "t":{"name_crust": "Crispy Thin", "size":{"M": 399, "L": 459}}, 
                        "c":{"name_crust": "Extreme Cheese", "size":{"M": 479, "L": 629}}}},
        "T": {"name_pizza": "Tom Yum Kung", 
              "crust": {"p":{"name_crust": "Pan", "size":{"M": 439, "L": 559}}, 
                        "t":{"name_crust": "Crispy Thin", "size":{"M": 399, "L": 519}}, 
                        "c":{"name_crust": "Extreme Cheese", "size":{"M": 539, "L": 689}}}},
        "P": {"name_pizza": "Pepperoni", 
              "crust": {"p":{"name_crust": "Pan", "size":{"M": 299, "L": 399}}, 
                        "t":{"name_crust": "Crispy Thin", "size":{"M": 279, "L": 399}}, 
                        "c":{"name_crust": "Extreme Cheese", "size":{"M": 419, "L": 569}}}},
    }

    while True:
        order = input("Enter you choose: ").upper()
        if order == "X":
            print("Thank you for using the service. See you next time!")
            break
        elif order not in menus:
            print("Your order is invalid")
            continue

        crust = input("Enter crust: ").lower()
        if crust not in menus[order]['crust']:
            print("Your order is invalid")
            continue
        size = input("Enter size: ").upper()
        if size not in menus[order]['crust'][crust]['size']:
            print("Your order is invalid")
            continue
        quantity = int(input("Enter quantity: "))

        print(f"Order by {name_cuz}")
        print(f"Pizza: {menus[order]['name_pizza']} -> {menus[order]['crust'][crust]['name_crust']}, size {size} = {menus[order]['crust'][crust]['size'][size]} x {quantity}")
        total += menus[order]['crust'][crust]['size'][size] * quantity
        print(f"Total = {total} Baht")

order_pizza()