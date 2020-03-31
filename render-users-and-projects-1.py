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
"Contact":          lambda fake, struct, user_struct:  fake.first_name() + ' ' + fake.last_name(),
"Title":          lambda fake, struct, user_struct:  fake.random_element(elements=("CFO","Sales Manager","Branch Manager")),
"Parent":          lambda fake, struct, user_struct:  fake.random_element(elements=("Arrow Truck", "IG Transportation")),
"COMPANY":          lambda fake, struct, user_struct:  fake.random_element(elements=("Arrow Truck", "IG Transportation")),
"Acct #":          lambda fake, struct, user_struct:  "S" + str(fake.random_int(min=10000, max=99999)),
"Category":          lambda fake, struct, user_struct:  fake.random_element(elements=("Seller", "Buyer")),
"User/Reigon":          lambda fake, struct, user_struct:  fake.random_element(elements=("Jon Levey", "")),
"Fleet Size":          lambda fake, struct, user_struct:  fake.random_element(elements=("18-20", "101-200", "N/A", "")),
"E-mail":          lambda fake, struct, user_struct:  fake.email(),
"PHONE":          lambda fake, struct, user_struct:  fake.msisdn(),
"Ext.":          lambda fake, struct, user_struct:  fake.random_int(min=100, max=999),
"Cell":          lambda fake, struct, user_struct:  fake.random_element(elements=("Arrow Truck")),
"Fax":          lambda fake, struct, user_struct:  fake.random_element(elements=("", "", fake.msisdn())),
"Address 1":          lambda fake, struct, user_struct:  fake.street_address(),
"Address 2":          lambda fake, struct, user_struct:  fake.random_element(elements=("", "A", "0")),
"CITY":          lambda fake, struct, user_struct:  fake.city(),
"State":          lambda fake, struct, user_struct:  fake.state(),
"ZIP":          lambda fake, struct, user_struct:  fake.zipcode(),
"Make":          lambda fake, struct, user_struct:  fake.random_element(elements=("", "Some make value")),
"Truck Type":          lambda fake, struct, user_struct:  fake.random_element(elements=("", "Some truck type")),
"Trailer Type":          lambda fake, struct, user_struct:  fake.random_element(elements=("", "Some trailer type")),
"First":          lambda fake, struct, user_struct:  fake.first_name(),
"Last":          lambda fake, struct, user_struct:  fake.last_name(),
"2ndary Email":          lambda fake, struct, user_struct:  fake.random_element(elements=("", "", "Used, Salvage", fake.email())),
"Bad Email":          lambda fake, struct, user_struct:  fake.random_element(elements=("", "Sleeper, DayCab, MedDuty")),
"Notes":          lambda fake, struct, user_struct:  fake.random_element(elements=("Trailer", "", "", ""))
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

    users_csv_writer = csv.DictWriter(users_csv, fieldnames=users_struct_builder.keys(), quoting=csv.QUOTE_ALL)
    users_csv_writer.writeheader()

    with open('objects.csv', 'w', newline='') as objects_csv:

        objects_csv_writer = csv.DictWriter(objects_csv, fieldnames=objects_struct_builder.keys(), quoting=csv.QUOTE_ALL)
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
