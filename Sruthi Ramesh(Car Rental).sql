create database carRental;
use carRental;

create table Vehicle(
	vehicleID int auto_increment primary key,
    make varchar(100),
    model varchar(100),
    year int,
    dailyRate decimal(5, 2),
    status enum('0', '1'),
    passengerCapacity int,
    engineCapacity int
);

create table Customer(
    customerID int auto_increment primary key,
    firstName varchar(100),
    lastName varchar(100),
    email varchar(100),
    phonenumber varchar(20)
);

create table Lease(
    leaseID int auto_increment primary key,
    vehicleID int,
    customerID int,
    startdate date,
    enddate date,
    type enum('Daily', 'Monthly'),
    foreign key (vehicleID) references Vehicle(vehicleID) on delete cascade,
    foreign key (customerID) references Customer(customerID) on delete cascade
);

create table Payment(
    paymentID int auto_increment primary key,
    leaseID int,
    paymentdate date,
    amount decimal(10, 2),
    foreign key (leaseID) references Lease(leaseID) on delete cascade
);

insert into Vehicle(vehicleID, make, model, Year, dailyRate, status, passengerCapacity, engineCapacity) values
    (1, 'Toyota', 'Camry', 2022, 50.00, '1', 4, 1450),
    (2, 'Honda', 'Civic', 2023, 45.00, '1', 7, 1500),
    (3, 'Ford', 'Focus', 2022, 48.00, '0', 4, 1400),
    (4, 'Nissan', 'Altima', 2023, 52.00, '1', 7, 1200),
    (5, 'Chevrolet', 'Malibu', 2022, 47.00, '1', 4, 1800),
    (6, 'Hyundai', 'Sonata', 2023, 49.00, '0', 7, 1400),
    (7, 'BMW', '3 Series', 2023, 60.00, '1', 7, 2499),
    (8, 'Mercedes', 'C-Class', 2022, 58.00, '1', 8, 2599),
    (9, 'Audi', 'A4', 2022, 55.00, '0', 4, 2500),
    (10, 'Lexus', 'ES', 2023, 54.00, '1', 4, 2500);
    
insert into Customer(customerID, firstName, lastName, email, phoneNumber) values
    (1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
    (2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
    (3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
    (4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
    (5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
    (6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
    (7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
    (8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
    (9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
    (10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');
    
insert into Lease (leaseID, vehicleID, customerID, startdate, enddate, type) values
    (1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
    (2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
    (3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
    (4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
    (5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
    (6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
    (7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
    (8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
    (9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
    (10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');

insert into Payment (paymentID, leaseID, paymentdate, amount) values
    (1, 1, '2023-01-03', 200.00),
    (2, 2, '2023-02-20', 1000.00),
    (3, 3, '2023-03-12', 75.00),
    (4, 4, '2023-04-25', 900.00),
    (5, 5, '2023-05-07', 60.00),
    (6, 6, '2023-06-18', 1200.00),
    (7, 7, '2023-07-03', 40.00),
    (8, 8, '2023-08-14', 1100.00),
    (9, 9, '2023-09-09', 80.00),
    (10, 10, '2023-10-25', 1500.00);
    
    SET SQL_SAFE_UPDATES = 0; -- disabling safe mode
    
 -- question 1)
 update Vehicle set dailyRate=68.00 where make='Mercedes';
 
 -- question 2)
 delete from Customer where customerID=1;
 
 -- question 3)
 alter table Payment rename column paymentdate to transactiondate;
 
 -- question 4)
select * from Customer where email = 'sarah@example.com';

-- question 5)
select * from Lease where customerID=3 and curdate() between startdate and enddate;
 
-- question 6)
SELECT p.paymentID, p.leaseID, p.transactiondate, p.amount
FROM Payment p
JOIN Lease l ON p.leaseID = l.leaseID
JOIN Customer c ON l.customerID = c.customerID
WHERE c.phoneNumber = '555-123-4567';

-- question 7)
select avg(dailyrate) from vehicle;

-- question 8)
select max(dailyrate) from vehicle; 

-- question 9)
select v.* from vehicle v
join Lease l on v.vehicleID=l.vehicleID
join Customer c on l.customerID=c.customerID
where c.customerID=3;

-- question 10)
select * from Lease order by enddate desc limit 1;

-- question 11)
select * from Payment where year(transactiondate)=2023;

-- question 12)
select c.*
from Customer c
left join Lease l on l.customerID=c.customerID
left join Payment p on p.leaseID=l.LeaseID
where p.paymentID is null;

-- question 13)
 select v.*,sum(p.amount) as totalPayments
 from vehicle v
 join Lease l on v.vehicleID=l.vehicleID
 join Payment p on l.leaseID=p.leaseID
 group by v.vehicleID;

-- question 14)
select c.*,sum(p.amount) as totalPayment
from payment p
left join Lease l on p.leaseID=l.leaseID
left join Customer c on l.customerID=c.customerID
group by c.customerID;

-- question 15)
select v.*,l.*
from vehicle v
join Lease l on v.vehicleID = l.vehicleID;

-- question 16)
select l.*,c.*,v.*
from Lease l
join Customer c on l.customerID=c.customerID
join Vehicle v on l.vehicleID=v.vehicleID
where enddate>=curdate();

-- question 17)
select c.*,sum(p.amount) as total_payment
from Customer c
join Lease l on c.customerID=l.customerID
join Payment p on l.leaseID = p.LeaseID
group by c.customerID order by total_payment desc limit 1;

-- question 18)
select v.*,l.startdate,l.enddate
from Vehicle v
left join Lease l on v.vehicleID=l.vehicleID;



 






