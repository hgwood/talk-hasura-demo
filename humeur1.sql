drop table if exists employees cascade;

create table employees (
  id serial primary key,
  first_name text not null,
  last_name text not null,
  manager_id int references employees (id) on delete set null
);

truncate table employees;

insert into employees
  (first_name, last_name, manager_id)
  values
    ('Benjamin', 'Burnley', null),
    ('Aaron', 'Fink', 1),
    ('Mark', 'Klepaski', 1),
    ('Jeremy', 'Hummel', 1),
    ('Chester', 'Bennington', null),
    ('Mike', 'Shinoda', 5),
    ('Brad', 'Delson', 5),
    ('Dave', 'Farrell', 5),
    ('Joe', 'Hahn', 5),
    ('Rob', 'Bourdon', 5);

drop table if exists moods;

create table moods (
  id serial primary key,
  value text not null,
  employee_id int references employees (id) on delete cascade,
  month int default extract(month from now()),
  year int default extract(year from now()),
  constraint one_mood_per_month_and_employee unique (employee_id, month, year)
);

truncate table moods;

insert into moods
  (value, employee_id, year, month)
  values
    ('cool', 1, 2019, 9),
    ('nice', 1, 2019, 8),
    ('meh', 2, 2019, 9),
    ('nice', 2, 2019, 8),
    ('cool', 3, 2019, 9),
    ('meh', 3, 2019, 8),
    ('not good', 4, 2019, 9),
    ('meh', 4, 2019, 8),
    ('cool', 5, 2019, 9),
    ('cool', 5, 2019, 8),
    ('cool', 6, 2019, 9),
    ('nice', 6, 2019, 8),
    ('cool', 7, 2019, 9),
    ('meh', 7, 2019, 8),
    ('meh', 8, 2019, 9),
    ('meh', 8, 2019, 8),
    ('cool', 9, 2019, 9),
    ('cool', 9, 2019, 8),
    ('not good', 10, 2019, 9),
    ('cool', 10, 2019, 8)
