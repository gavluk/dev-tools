#!/usr/bin/env python3

# Configure any additional field generation lambdas
# use https://faker.readthedocs.io/en/stable/providers/BaseProvider.html 
users_struct_builder = {
    "username":         lambda fake, struct: fake.lexify(text='?????') + '.' + fake.email(),
    "password":         lambda fake, struct: fake.bothify(text="????????") if args.random_passwords else args.same_password,
    "first_name":       lambda fake, struct: fake.first_name(),
    "last_name":        lambda fake, struct: fake.last_name(),
    "company":          lambda fake, struct: fake.company() + ' ' + fake.company_suffix(),
    "type_specific":    lambda fake, struct: fake.random_element(elements=("clerking","surveyor","home_inspection","title_company","broker","attorney","developer")),
}

# Configure any additional object fields
# use https://faker.readthedocs.io/en/stable/providers/BaseProvider.html
objects_struct_builder = {    
    "username":         lambda fake, struct, user_struct: user_struct["username"],
    "password":         lambda fake, struct, user_struct: user_struct["password"],
    "country":          lambda fake, struct, user_struct: "USA", #fake.country(),
    "units":            lambda fake, struct, user_struct: fake.random_int(min=1000000, max=1000000),
    "city":             lambda fake, struct, user_struct: fake.city(),
    "streetaddress":    lambda fake, struct, user_struct: fake.street_address(),
    "project_name":     lambda fake, struct, user_struct: struct['city'] + ", " + struct['streetaddress'],
    "roles":            lambda fake, struct, user_struct: fake.random_element(elements=('seller_attorney','seller','buyer','buyer_attorney','seller_broker','seller_2','seller_3','lender','buyer_broker')),
    "represented_name": lambda fake, struct, user_struct: fake.first_name() + ' ' + fake.last_name(),
    "represented_email":lambda fake, struct, user_struct: fake.email(),
    "represented_name2": lambda fake, struct, user_struct: fake.first_name() + ' ' + fake.last_name(),
    "represented_email2":lambda fake, struct, user_struct: fake.email(),
    "broker_name":      lambda fake, struct, user_struct: fake.first_name() + ' ' + fake.last_name(),
    "broker_email":     lambda fake, struct, user_struct: fake.email(),
    "attorney_name":    lambda fake, struct, user_struct: fake.first_name() + ' ' + fake.last_name(),
    "attorney_email":   lambda fake, struct, user_struct: fake.email(),
    "states":           lambda fake, struct, user_struct: fake.military_state(),
    "zip":              lambda fake, struct, user_struct: fake.zipcode(),
}

import sys
import argparse
import csv
from faker import Faker

fake = Faker()

parser = argparse.ArgumentParser(
    description = 'Generates two files: `users.csv` list of N random users, `objects.csv` list of random objects'
)
parser.add_argument('--users', '-u', help='Users to generate', default=10, type=int)
parser.add_argument('--random_passwords', help='Generates random password for each user', action='store_true')
parser.add_argument('--same_password', help='Which password to use for all users', default=fake.bothify(text="????????"))
parser.add_argument('--objects_min', '-omin', help='Minimum of objects per user', default=0, type=int)
parser.add_argument('--objects_max', '-omax', help='Maximum of objects per user', default=5, type=int)
args = parser.parse_args()

print('Going to generate', args.users, 'users having from', args.objects_min, 'to', args.objects_max, 'objects');

with open('users.csv', 'w', newline='') as users_csv:

    users_csv_writer = csv.DictWriter(users_csv, fieldnames=users_struct_builder.keys())
    users_csv_writer.writeheader()

    with open('objects.csv', 'w', newline='') as objects_csv:

        objects_csv_writer = csv.DictWriter(objects_csv, fieldnames=objects_struct_builder.keys())
        objects_csv_writer.writeheader()

        # Run rendering for users
        for user_no in range(0, args.users):

            # building one user    
            user_struct = {}
            for key in users_struct_builder:
                user_struct[key] = (users_struct_builder[key](fake, user_struct))
            
            #print("USER\t", user_struct)
            users_csv_writer.writerow(user_struct)

            # building some number of objects
            for _ in range(0, fake.random_int(min=args.objects_min, max=args.objects_max)):
                object_struct = {}

                for key in objects_struct_builder:
                    object_struct[key] = objects_struct_builder[key](fake, object_struct, user_struct)

                #print("OBJECT\t", object_struct)
                objects_csv_writer.writerow(object_struct)

            sys.stdout.write("\rUsers generated: %d%%" % ((user_no+1) / args.users * 100))
            sys.stdout.flush()

print("\nDone")
