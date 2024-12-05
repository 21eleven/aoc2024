
input_file = "example.txt"
# input_file = "input.txt"
with open(input_file, "r") as fh:
    input_str = fh.read() 
[rules_str, order_str] = input_str.split("\n\n")
rules_str = rules_str.strip()
order_str = order_str.strip()

rules = [(rule.split("|")[0], rule.split("|")[1]) for rule in rules_str.splitlines()]
print(rules)

orders = [order.split(",") for order in order_str.splitlines()]
print(orders)

def part1and2lol(rules, orders):
    # part1
    valid_orders = []
    invalids = []
    orders = [{val:i for (i, val) in enumerate(order)} for order in orders]
    for order in orders:
        print(order)
        valid = True
        for (l,r) in rules:
            if (l_idx := order.get(l)) is not None and (r_idx := order.get(r)) is not None:
                if l_idx < r_idx:
                    continue
                valid = False
                break
        if valid:
            insert = sorted(order.items(), key=lambda x: x[1])
            insert = [key for (key, _idx) in insert]
            # print(insert)
            valid_orders.append(insert)
        else:
            invalids.append(order)
    out = sum(int(order[len(order)//2]) for order in valid_orders)
    print(out)
    # part2
    def make_right(rules, order):
        for (l,r) in rules:
            if (l_idx := order.get(l)) is not None and (r_idx := order.get(r)) is not None:
                if l_idx < r_idx:
                    continue
                #swap
                order[l] = r_idx
                order[r] = l_idx
                return make_right(rules, order)
        return order
    out2 = 0
    for invalid in invalids:
        proper = make_right(rules, invalid)
        insert = sorted(proper.items(), key=lambda x: x[1])
        insert = [key for (key, _idx) in insert]
        out2 += int(insert[len(insert)//2])
    print(out2)



part1and2lol(rules, orders)
        
        
