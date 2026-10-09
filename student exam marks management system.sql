-----creations of the tables-------
create table students(
student_id int primary key,
student_name varchar(50) not null,
branch varchar(10) check (branch in('cse','ece','it','civil','mech','eee')),
pursuing_year int check ( pursuing_year between 1 and 4)
);
create table subjects(
subject_id varchar(10) primary key not null,
subject_name varchar(50) not null,
credits int
);

create table marks(
student_id int,
subject_id varchar(10),
marks int check (marks<100),
primary key (student_id,subject_id),
foreign key (student_id)
references students(student_id),
foreign key (subject_id)
references subjects(subject_id));

----insertion of the data into tables--------
insert into students(student_id,student_name,branch,pursuing_year)
values(101,'rahul','cse',2),
(102,'priya','cse',2),
(103,'kiran','ece',2);


insert into subjects(subject_id,subject_name,credits)
values('cs301','dbms',4),
('cs302','java',3),
('cs303','python',3);

insert into marks(student_id,subject_id,marks)
values(101,'cs301',82),
(101,'cs302',75),
(101,'cs303',91),
(102,'cs301',94),
(102,'cs302',87),
(103,'cs301',68);

----find the topper in dbms------
select s.student_id,s.student_name,m.marks 
from marks m
join students s on m.student_id=s.student_id
join subjects sub on m.subject_id=sub.subject_id
where sub.subject_name='dbms'
order by m.marks desc
limit 1;

-----find students scoring above 80 in all subjects -------
select s.student_id,student_name
from marks m
join students s on m.student_id=s.student_id
group by s.student_id,student_name
having min(m.marks)>80;

------ calculate average marks of each subject------
select subject_name,avg(m.marks) 
from marks m
join subjects s on m.subject_id=s.subject_id
group by subject_name;

-------find students who failed========
select  distinct s.student_id,s.student_name
from marks m
join students s on m.student_id=s.student_id
where m.marks<45;

-------- display cgpa average marks per student-------
select s.student_id,s.student_name,avg(marks) as average_salary
from marks m
join students s on m.student_id=s.student_id
group by s.student_id,s.student_name;
