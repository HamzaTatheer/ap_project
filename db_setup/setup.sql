--alter database HealthStreet set multi_user with rollback immediate
create database HealthStreet;
go
use HealthStreet;


create table [validation](
Email  varchar(30) primary key,
[Password] nvarchar(20) NULL,
Usertype char 
)
go
create table patient(
PatientID int primary key,
Name nvarchar(30) not NULL,
Email  varchar(30) not NULL,
City nvarchar(30) not NULL,
Gender varchar(6) not NULL,
Age int,
Phone nvarchar(12) not NULL,
[Address] nvarchar(30) not NULL
foreign key (Email) references [validation](Email)
)
go

create table patient_pictures(
PatientID int primary key,
imgName nvarchar(30) not NULL,
[path]  nvarchar(50) not NULL,
foreign key (PatientID) references patient(PatientID)
)

go
create table Doctor(
DoctorID int primary key,
Name nvarchar(30) not NULL,
Email varchar(30)not NULL,
City nvarchar(30) not NULL,
Gender varchar(6) not NULL,
Age int,
Phone nvarchar(12) not NULL,
Fee int,
foreign key (Email) references [validation](Email)
)
go
create table Doctor_pictures(
DoctorID int primary key,
imgName nvarchar(30) not NULL,
[path]  nvarchar(50) not NULL,
foreign key (DoctorID) references Doctor(DoctorID)
)
go
create table Doctor_specialization(
DoctorID int,
[Name] nvarchar(30),
primary key(DoctorID,[Name]),
foreign key (DoctorID) references Doctor(DoctorID)
)
go
create table Doctor_availablity(
DoctorID  int primary key,
starting_time time not NULL,
ending_time time not NULL,
foreign key (DoctorID) references Doctor(DoctorID)
)
go

create table Prescription(
PresID int not NULL,
PatientID int not NULL,
DoctorID int not NULL,
Disease_diagnosed varchar(30) not NULL,
PresDate Date not NULL,
primary key(PresID),
foreign key (PatientID) references patient(PatientID),
foreign key (DoctorID) references Doctor(DoctorID)
)
go
create table Prescribed_medicines(
PresID int not NULL,
Medicine varchar(20) not NULL,
Quantity int not NULL,
primary key(PresID,Medicine),
foreign key (PresID) references Prescription(PresID),
)
go
create table Prescribed_tests(
PresID int not NULL,
Test varchar(20) not NULL,
primary key(PresID,Test),
foreign key (PresID) references Prescription(PresID)
)
go
create table patient_history(
PatientID int not NULL,
PresID int not NULL,
primary key(PatientID,PresID),
foreign key (PatientID) references patient(PatientID),
foreign key (PresID) references Prescription(PresID)
)
go
create table Bills(
PresID int primary key,
Bill int,
[status] int,
foreign key (PresID) references Prescription(PresID)
)
go
create table Available_appointments(
AppID  int primary key,
starting_time time not NULL,
ending_time time not NULL,
AppDate date not NULL,
DoctorID  int,
PatientID  int,
AppStatus int,
foreign key (PatientID) references patient(PatientID),
foreign key (DoctorID) references Doctor(DoctorID)
)
go



--///////////////////////////////////////////////Stored Procedures

create procedure signin
@email nvarchar(30),@password nvarchar(20)
as
begin
declare @temp char
		if exists (select Usertype=@temp from [validation] where @password = [Password] AND @email = Email)
		begin
			select Usertype
			from [validation]
			where @password = [Password] AND @email = Email
		end
end
go
--------------------------------------------------------------------------------------
create procedure signup
@email nvarchar(30),@password nvarchar(20),@utype char,
@output int output
as
begin
		if exists (select * from [validation] where @email = Email)
		begin
			set @output = 0
		end
		else
		begin
			insert into [validation] values(@email,@password,@utype)		
			declare @id int
			Set @id=(Select Count(*) from patient) + 1
			insert into patient values (@id,0,@Email,'0','0',0,'0', '0');
			insert into patient_pictures values(@id,'0','0')
			set @output = 1
		end
end
go
----------------------------------------------------------------------------------------
create procedure insertPatientinfo
@Email nvarchar(30), @Name nvarchar(30), @City nvarchar(30), @Gender nvarchar(6), @Age int, @Phone nvarchar(12), @Address nvarchar(30),@imgName nvarchar(30),@path nvarchar(50),
@output int output
as
begin
	if not exists (select * from patient where @Email = Email)
	begin
		set @output = 0  --not exists
	end
	else 
	begin
	declare @pid int

		Set @pid=(select PatientID from patient where @Email=Email)
		update patient set [Name]=@Name,City=@City,Gender=@Gender,Age=@Age,Phone=@Phone, [Address]=@Address
		where @Email=Email
		update patient_pictures set imgName=@imgName,[path]=@path
		where @pid=PatientID
	end
	set @output = 1
end

go
---------------------------------------------------------------------------------------------
create procedure patientcount
@output int output
as
begin
Set @output=(Select Count(*) from patient)
end
go
create procedure doctorcount
@output int output
as
begin
Set @output=(Select Count(*) from Doctor)
end
go
create procedure AllUsersAuth
As
begin
	Select *
	from validation
end
go
--------------------------------------------------------------------------------------------------
create procedure AllPatients
As
begin
	Select *
	from patient join patient_pictures as p on patient.PatientID=p.PatientID
end
go

---------------------------------------------------------------
create procedure getAllDoctors
As
begin
	Select x.DoctorID,x.Name,x.Email,x.City,x.Gender,x.Age,x.Phone,x.Fee,d.imgName,a.starting_time,a.ending_time
	from Doctor as x join Doctor_pictures as d on x.DoctorID=d.DoctorID join Doctor_availablity as a on x.DoctorID=a.DoctorID
end
go

--------------------------------------------------------------------------------------------------
create procedure getDoctorSpecialization
@docID int
As
begin
	Select Doctor_specialization.Name
	from Doctor join Doctor_specialization on Doctor.DoctorID=Doctor_specialization.DoctorID
	where @docID=Doctor.DoctorID
end
go

--------------------------------------------------------------------------------------------------




create procedure getPatientAppointments
@pid int,
@output int output
as
begin
		if exists (Select * from patient as p join Available_appointments as a on a.PatientID=p.PatientID where a.AppStatus=1 AND @pid=p.PatientID)
		begin
			set @output = 1         
			
			select a.AppID,d.Name,a.AppDate,a.starting_time,a.ending_time

			from Available_appointments as a join Doctor as d on a.DoctorID=p.DoctorID 
			where a.AppStatus=1 AND @pid=a.PatientID
		end
	else
		begin
			set @output = 0	          --there is no appointment available
		end
	
end
go






--------------------------------------------------------------------------------------------------
create procedure getDocAppointments
@docid int,
@output int output
as
begin
		if exists (Select * from Doctor as d join Available_appointments as a on a.DoctorID=d.DoctorID where a.AppStatus=1 AND @docid=d.DoctorID)
		begin
			set @output = 1         
			
			select a.AppID,p.Name,a.AppDate,a.starting_time,a.ending_time
			from Available_appointments as a join patient as p on a.PatientID=p.PatientID 
			where a.AppStatus=1 AND @docid=a.DoctorID
		end
	else
		begin
			set @output = 0	          --there is no appointment available
		end
	
end
go
--------------------------------------------------------------------------------------------------
create procedure Available_Slots
@date date,@docid int,
@output int output
as
begin
declare @temp date
		set @temp = Convert(date,getdate())
		delete from Available_appointments where @temp>AppDate
		if exists (Select * from Doctor as d join Available_appointments as a on a.DoctorID=d.DoctorID where a.AppStatus=0 AND @docid=d.DoctorID AND @date=a.AppDate)
		begin
					
			set @output = 1            --there is an appointment available
			
			select a.AppID,a.starting_time,a.ending_time,d.[Name]
			from (Available_appointments as a join Doctor as d on d.DoctorID=a.DoctorID) 
			where a.AppStatus=0 AND @docid=d.DoctorID AND @date=a.AppDate
		end
	else
		begin
			set @output = 0	          --there is no appointment available
		end
	
end
go
----------------------------------------------------------------------------------------------------

create procedure Book_appointment
@patientid int,@appid char(5),
@output int output
as
begin
		if exists (Select * from Available_appointments as a where @appid=a.AppID)
		begin
			set @output = 1            --there is an appointment available
			
			update Available_appointments
			set PatientID=@patientid
			where AppID=@appid

			update Available_appointments
			set AppStatus=1
			where AppID=@appid

		end
	else
		begin
			set @output = 0	          --there is no appointment available
		end
	
end
go
--------------------------------------------------------------------------------------------------
create procedure Get_all_Doctors
as
begin
	select d.DoctorID,d.[Name],d1.[Name] as specialization
	from Doctor as d join Doctor_specialization as d1 on d.DoctorID=d1.DoctorID 
end
go
--------------------------------------------------------------------------------------------------

create procedure get_patient_history
@Email nvarchar(30)
as
begin
	declare @id int
	set @id = (select PatientID from patient where Email=@Email)

		select z.[Name], y.PresDate,y.Disease_diagnosed,x.PresID
		from (patient_history x join Prescription y on x.PresID=y.PresID) join Doctor z on y.DoctorID=z.DoctorID
		where x.PatientID=@id
end
go

--------------------------------------------------------------------------------------------------
create procedure get_prescriebed_med
@pres_id int
as
begin 
	select Medicine,Quantity
	from Prescribed_medicines
	where PresID=@pres_id
end

go

--------------------------------------------------------------------------------------------------
create procedure get_prescriebed_test
@pres_id int
as
begin 
	select Test
	from Prescribed_tests
	where PresID=@pres_id
end


go

--------------------------------------------------------------------------------------------------
create procedure get_patient
@Email varchar(30)
as 
begin
	select *
	from patient join patient_pictures as p on patient.PatientID=p.PatientID
	where Email = @Email
end
go

--------------------------------------------------------------------------------------------------
create procedure get_doctor
@Email varchar(30)
as 
begin
	select *
	from Doctor join Doctor_pictures as p on Doctor.DoctorID=p.DoctorID join Doctor_availablity as a on Doctor.DoctorID=a.DoctorID
	where Email = @Email
end
go

--------------------------------------------------------------------------------------------------

create procedure addprescription_history_bill
@appid int,@disease nvarchar(30),
@output int output
as
begin
declare @check int

		declare @id int,@pid int,@docid int,@date date
		Set @id=(Select Count(*) from Prescription) + 1
		
		if exists(select * from Available_appointments	where @appid=AppID And AppStatus=1)
		begin
			Select @pid=PatientID,@docid=DoctorID,@date=Convert(date,AppDate)
			from Available_appointments
			where @appid=AppID And AppStatus=1		
			insert into Prescription values (@id,@pid,@docid,@disease,@date)
			set @check=1
		end
		
		if (@check=1)
		begin
			declare @bill int
			Set @bill=(Select Fee from Doctor where @docid=DoctorID)
			insert into Bills values (@id,@bill,0)
			insert into patient_history values (@pid,@id)
			update Available_appointments set AppStatus=2 where @appid=AppID
		end
		set @output=@id
end
go

--------------------------------------------------------------------------------------------------
create procedure addprescribedmed
@presid int,@med nvarchar(20),@quantity int
as 
begin 
	insert into Prescribed_medicines values(@presid,@med,@quantity)
end
go

--------------------------------------------------------------------------------------------------
create procedure addprescribedtest
@presid int,@test nvarchar(20)
as 
begin 
	insert into Prescribed_tests values(@presid,@test)
end
go

--------------------------------------------------------------------------------------------------
create procedure getAppointmentbyid
@appid int
as 
begin
	select d.[Name] as d,p.[Name] as p,p.Age,p.Gender,Convert(date,AppDate) as AppDate
	from Available_appointments as a join Doctor as d on a.DoctorID=d.DoctorID join patient as p on a.PatientID=p.PatientID
	where AppStatus=1 And @appid=AppID
end

go
--------------------------------------------------------------------------------------------------

create procedure Booked_Appointments as
begin
	select x.starting_time as appTime1,x.ending_time as appTime2, y.Name as Patient, z.Name as Doctor, x.AppDate
	from (Available_appointments x join patient y on x.PatientID=y.PatientID) join Doctor z on x.DoctorID = z.DoctorID
	where x.AppDate >= CONVERT(date, getdate()) and x.AppStatus = 1
end

go
--------------------------------------------------------------------------------------------------
create procedure AppointNewDoctor
@Name nvarchar(30),@Email nvarchar(30), @City nvarchar(30), @Gender nvarchar(6), @Age int, @phone nvarchar(12),@fee int,@imgName nvarchar(30),@path nvarchar(50),
@output int output,@DoctorID int output
as
begin
	if exists (select DoctorID from Doctor where @Email = Email )
	begin
		set @DoctorID=-1;
		set @output = 0    ---id is not unique
	end
	else
	begin
	declare @temp int
		set @temp=(Select Count(*) from Doctor)+1;
		insert into Doctor values (@temp, @Name,@Email, @City, @Gender, @Age, @phone,@fee);
		insert into Doctor_pictures values (@temp,@imgName,@path);
		insert into Doctor_availablity values(@temp,'17:00:00','22:00:00')
	end
	set @output = 1
	set @DoctorID=@temp
end

----------------------------------------*************

go
create procedure addSpecialization
@DoctorID int, @Name nvarchar(30),
@output int output
as
begin
	if exists (select DoctorID from Doctor where @DoctorID = DoctorID )
		begin	
			set @output = 1;
			insert into Doctor_specialization values(@DoctorID , @Name);		
		end
	else
		begin
			set @output = 0  ---Doctor dont exist
		end
end

-----------------------------------------------------------------------------------------------------------------------------------------

go
create procedure addValidation
@Email nvarchar(30),@password nvarchar(20),@usertype char,
@output int output
as
begin
	if exists (select * from validation where @Email = Email)
		begin
			set @output = 0  
		end
	else
		begin
			set @output = 1;
			insert into [validation] values(@Email,@password,@usertype);		
			---Doctor dont exist
		end
end
go
--------------------------------------------------------------------------------------------------

create procedure get_unpaid_bill as
begin
	select x.PresID, y.PresDate, z.Name as Doctor, a.Name as Patient, x.Bill,x.status
	from ((Bills x join Prescription y on x.PresID=y.PresID) join Doctor z on y.DoctorID=z.DoctorID) join patient a on y.PatientID=a.PatientID
	order by x.status
end

go
--------------------------------------------------------------------------------------------------

create procedure update_payment_status
@PresID int 
as
begin
	update Bills
	set Bills.status = 1
	where PresID=@PresID
end


--------------------------------------------------------------------------------------------------
go
insert into validation values ('admin@gmail.com','root','A');        --important do not remove
go

--------------------------------------------------------------------------------------------------
create procedure getPatientBills
@email nvarchar(30) 
as
begin
	Select PresDate as date,d.[Name],Bill,status
	from Bills as b join Prescription as p on b.PresID=p.PresID join Doctor as d on p.DoctorID=d.DoctorID join patient as pt on pt.PatientID=p.PatientID join validation as v on v.Email=pt.Email
	where pt.Email=@email
end
go

--------------------------------------------------------------------------------------------------
create procedure insert_appointments 
@DoctorID int
as 
begin

--- declaring all data
declare @end_time time(7)
declare @count int
declare @start_time time(7)
declare @temp time(7)
declare @date Date
declare @end_date Date

---setting all data value

if((select Count(*) from Available_appointments)=0)
	begin
		set @count=1
	end
else
	begin
		set @count = (select Max(AppID) from Available_appointments)+1
	end
set @date = CONVERT(date, getdate())
set @end_date = CONVERT(date, GETDATE())
set @end_date = DATEADD(day, 8, @end_date)
set @date = DATEADD(day, 1, @date)

------inserting values

	while @date < @end_date
	begin
		
		select @start_time= starting_time, @end_time= ending_time
		from Doctor_availablity
		where DoctorID = @DoctorID

		set @temp = @start_time
		set @temp = DATEADD(minute, 30, @temp)

		while @start_time < @end_time
		begin
			if exists (select AppID from Available_appointments where starting_time = @start_time and DoctorID=@DoctorID and AppDate = @date)
				begin
					set @start_time = @temp
					set @temp = DATEADD(minute, 30, @temp)
				end
			else
				begin
					insert into Available_appointments values(@count, @start_time, @temp, @date, @DoctorID,NULL,0)
					set @start_time = @temp
					set @temp = DATEADD(minute, 30, @temp)
					set @count = @count + 1
				end
		end
		set @date = DATEADD(day, 1, @date)

	end

end
go

--------------------------------------------------------------------------------------------------
create procedure updateAvailability
@DoctorID int,@start time,@end time
as 
begin
	if exists (select * from Doctor where @DoctorID=DoctorID)
		begin
			update Doctor_availablity set starting_time=@start,ending_time=@end where DoctorID=@DoctorID
		end
end

go

--------------------------------------------------------------------------------------------------
