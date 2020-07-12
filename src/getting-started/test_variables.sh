: '
    Rules for naming variables in shell

    1) Avoid hypens e.g my-name, instead use underscores
    2) Variables are case senstive i.e MYNAME is not equal to myname
    3) Use descriptive names
'

# Enable debugging
set -x

name=mazino
age=25
role="software engineer"
year=2020
company=andela

echo As at $year, $name is a $role at $company