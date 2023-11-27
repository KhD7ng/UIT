create database QLCB
use QLCB


--Tao bang
create table KHACHHANG
(
	MAKH	nvarchar(15) not null,
	TEN		nvarchar(15),
	DCHI	nvarchar(50),
	DTHOAI	nvarchar(12)
)
create table NHANVIEN
(
	MANV	nvarchar(15) not null,
	TEN		nvarchar(15),
	DCHI	nvarchar(50),
	DTHOAI	nvarchar(12),
	LUONG	float,
	LOAINV	bit
)
create table LOAIMB
(
	MALOAI	nvarchar(15) not null,
	HANGSX	nvarchar(15)
)
create table MAYBAY
(
	SOHIEU	int not null,
	MALOAI	nvarchar(15) not null
)
create table CHUYENBAY
(
	MACB	nvarchar(4) not null,
	SBDI	varchar(3),
	SBDEN	varchar(3),
	GIODI	datetime,
	GIODEN	datetime
)
create table LICHBAY
(
	NGAYDI	datetime not null,
	MACB	nvarchar(4) not null,
	SOHIEU	int,
	MALOAI	nvarchar(15)
)
create table DATCHO
(	
	MAKH	nvarchar(15) not null,
	NGAYDI	datetime not null,
	MACB	nvarchar(4) not null
)
create table KHANANG
(
	MANV	nvarchar(15) not null,
	MALOAI	nvarchar(15) not null
)
create table PHANCONG
(
	MANV	nvarchar(15) not null,
	NGAYDI	datetime not null,
	MACB	nvarchar(4) not null
)

--tao khoa chinh
alter table KHACHHANG
add constraint PK_MAKH primary key (MAKH)

alter table NHANVIEN
add constraint PK_MANV primary key (MANV)

alter table LOAIMB
add constraint PK_MALOAI primary key (MALOAI)

alter table MAYBAY
add constraint PK_SOHIEU_MALOAI primary key (SOHIEU,MALOAI)

alter table CHUYENBAY
add constraint PK_MACB primary key (MACB)

alter table LICHBAY
add constraint PK_NGAYDI_MACB primary key (NGAYDI,MACB)

alter table DATCHO
add constraint PK_MAKH_NGAYDI_MACB primary key (MAKH,NGAYDI,MACB)

alter table KHANANG
add constraint PK_MANV_MALOAI primary key (MANV,MALOAI)

alter table PHANCONG
add constraint PK_MANV_NGAYDI_MACB primary key (MANV,NGAYDI,MACB)

--tao khoa ngoai
alter table MAYBAY
add constraint FK_MALOAI foreign key (MALOAI) references LOAIMB(MALOAI)

alter table LICHBAY
add constraint FK_SOHIEU_MALOAI foreign key (SOHIEU,MALOAI) references MAYBAY(SOHIEU,MALOAI)

alter table LICHBAY
add constraint FK_MACB foreign key (MACB) references CHUYENBAY(MACB)

alter table DATCHO
add constraint FK_MAKH foreign key (MAKH) references KHACHHANG(MAKH)

alter table DATCHO
add constraint FK_NGAYDI_MACB foreign key (NGAYDI,MACB) references LICHBAY(NGAYDI,MACB)

alter table KHANANG
add constraint FK_MANV foreign key (MANV) references NHANVIEN(MANV)

alter table KHANANG
add constraint FK_MALOAI_KHANANG foreign key (MALOAI) references LOAIMB(MALOAI)

alter table PHANCONG
add constraint FK_MANV_PHANCONG foreign key (MANV) references NHANVIEN(MANV)

alter table PHANCONG
add constraint FK_NGAYDI_MACB_PHANCONG foreign key (NGAYDI,MACB) references LICHBAY(NGAYDI,MACB)


--du lieu
-- bang KHACHHANG
insert into KHACHHANG
values ('0009','Nga','223 Nguyen Trai','8932320')
insert into KHACHHANG
values ('0101','Anh','567 Tran Phu','8826729')
insert into KHACHHANG
values ('0045','Thu','285 Le Loi','8932203')
insert into KHACHHANG
values ('0012','Ha','435 Quang Trung','8933232')
insert into KHACHHANG
values ('0238','Hung','456 Pasteur','9812101')
insert into KHACHHANG
values ('0397','Thanh','234 Le Van Si','8952943')
insert into KHACHHANG
values ('0582','Mai','789 Nguyen Du',null)
insert into KHACHHANG
values ('0934','Minh','678 Le Lai',null)
insert into KHACHHANG
values ('0091','Hai','345 Hung Vuong','8893223')
insert into KHACHHANG
values ('0314','Phuong','395 Vo Van Tan','8232320')
insert into KHACHHANG
values ('0613','Vu','348 CMT8','8343232')
insert into KHACHHANG
values ('0586','Son','123 Bach Dang','8556223')
insert into KHACHHANG
values ('0422','Tien','75 Nguyen Thong','8332222')
go

--bang NHANVIEN
insert into NHANVIEN
values ('1006','Chi','12/6 Nguyen Kiem','8120012',150000,0)
insert into NHANVIEN
values ('1005','Giao','65 Nguyen Thai Son','8324467',500000,0)
insert into NHANVIEN
values ('1001','Huong','8 Dien Bien Phu','8330733',500000,1)
insert into NHANVIEN
values ('1002','Phong','1 Ly Thuong Kiet','8308117',450000,1)
insert into NHANVIEN
values ('1004','Phuong','351 Lac Long Quan','8308155',250000,0)
insert into NHANVIEN
values ('1003','Quang','78 Truong Dinh','8324461',350000,1)
insert into NHANVIEN
values ('1007','Tam','36 Nguyen Van Cu','8458188',500000,0)
go

--bang LOAIMB
insert into LOAIMB
values ('A310','Airbus')
insert into LOAIMB
values ('A320','Airbus')
insert into LOAIMB
values ('A330','Airbus')
insert into LOAIMB
values ('A340','Airbus')
insert into LOAIMB
values ('B727','Boeing')
insert into LOAIMB
values ('B747','Boeing')
insert into LOAIMB
values ('B757','Boeing')
insert into LOAIMB
values ('DC10','MD')
insert into LOAIMB
values ('DC9','MD')
go

--bang MAYBAY
insert into MAYBAY
values (10,'B747')
insert into MAYBAY
values (11,'B727')
insert into MAYBAY
values (13,'B727')
insert into MAYBAY
values (13,'B747')
insert into MAYBAY
values (21,'DC10')
insert into MAYBAY
values (21,'DC9')
insert into MAYBAY
values (22,'B757')
insert into MAYBAY
values (22,'DC9')
insert into MAYBAY
values (23,'DC9')
insert into MAYBAY
values (24,'DC9')
insert into MAYBAY
values (70,'A310')
insert into MAYBAY
values (80,'A310')
insert into MAYBAY
values (93,'B757')
go

--bang CHUYENBAY
insert into CHUYENBAY
values ('100','SLC','BOS','08:00','17:50')
insert into CHUYENBAY
values ('112','DCA','DEN','14:00','18:07')
insert into CHUYENBAY
values ('121','STL','SLC','07:00','09:13')
insert into CHUYENBAY
values ('122','STL','YYV','08:30','10:19')
insert into CHUYENBAY
values ('206','DFW','STL','09:00','11:40')
insert into CHUYENBAY
values ('330','JFK','YYV','16:00','18:53')
insert into CHUYENBAY
values ('334','ORD','MIA','12:00','14:14')
insert into CHUYENBAY
values ('335','MIA','ORD','15:00','17:14')
insert into CHUYENBAY
values ('336','ORD','MIA','18:00','20:14')
insert into CHUYENBAY
values ('337','MIA','ORD','20:30','23:53')
insert into CHUYENBAY
values ('394','DFW','MIA','19:00','21:30')
insert into CHUYENBAY
values ('395','MIA','DFW','21:00','23:43')
insert into CHUYENBAY
values ('449','CDG','DEN','10:00','19:29')
insert into CHUYENBAY
values ('930','YYV','DCA','13:00','16:10')
insert into CHUYENBAY
values ('931','DCA','YYV','17:00','18:10')
insert into CHUYENBAY
values ('932','DCA','YYV','18:00','19:10')
insert into CHUYENBAY
values ('991','BOS','ORD','17:00','18:22')
go

--bang LICHBAY
insert into LICHBAY
values ('11/1/2000','100',80,'A310')
insert into LICHBAY
values ('11/1/2000','112',21,'DC10')
insert into LICHBAY
values ('11/1/2000','206',22,'DC9')
insert into LICHBAY
values ('11/1/2000','334',10,'B747')
insert into LICHBAY
values ('11/1/2000','395',23,'DC9')
insert into LICHBAY
values ('11/1/2000','991',22,'B757')
insert into LICHBAY
values ('11/1/2000','337',10,'B747')
insert into LICHBAY
values ('10/31/2000','100',11,'B727')
insert into LICHBAY
values ('10/31/2000','112',11,'B727')
insert into LICHBAY
values ('10/31/2000','206',13,'B727')
insert into LICHBAY
values ('10/31/2000','334',10,'B747')
insert into LICHBAY
values ('10/31/2000','335',10,'B747')
insert into LICHBAY
values ('10/31/2000','337',24,'DC9')
insert into LICHBAY
values ('10/31/2000','449',70,'A310')
go

--bang DATCHO
insert into DATCHO
values ('0009','11/1/2000','100')
insert into DATCHO
values ('0009','10/31/2000','449')
insert into DATCHO
values ('0045','11/1/2000','991')
insert into DATCHO
values ('0012','10/31/2000','206')
insert into DATCHO
values ('0238','10/31/2000','334')
insert into DATCHO
values ('0582','11/1/2000','991')
insert into DATCHO
values ('0091','11/1/2000','100')
insert into DATCHO
values ('0314','10/31/2000','449')
insert into DATCHO
values ('0613','11/1/2000','100')
insert into DATCHO
values ('0586','11/1/2000','991')
insert into DATCHO
values ('0586','10/31/2000','100')
insert into DATCHO
values ('0422','10/31/2000','449')
go

--bang KHANANG
insert into KHANANG
values ('1001','B727')
insert into KHANANG
values ('1001','B747')
insert into KHANANG
values ('1001','DC10')
insert into KHANANG
values ('1001','A310')
insert into KHANANG
values ('1002','A320')
insert into KHANANG
values ('1002','A340')
insert into KHANANG
values ('1002','B757')
insert into KHANANG
values ('1002','DC9')
insert into KHANANG
values ('1003','A310')
insert into KHANANG
values ('1003','DC9')
go

--bang PHANCONG
insert into PHANCONG
values ('1001','11/1/2000','100')
insert into PHANCONG
values ('1001','10/31/2000','100')
insert into PHANCONG
values ('1002','11/1/2000','100')
insert into PHANCONG
values ('1002','10/31/2000','100')
insert into PHANCONG
values ('1003','10/31/2000','100')
insert into PHANCONG
values ('1003','10/31/2000','337')
insert into PHANCONG
values ('1004','10/31/2000','100')
insert into PHANCONG
values ('1004','10/31/2000','337')
insert into PHANCONG
values ('1005','10/31/2000','337')
insert into PHANCONG
values ('1006','11/1/2000','991')
insert into PHANCONG
values ('1006','10/31/2000','337')
insert into PHANCONG
values ('1007','11/1/2000','112')
insert into PHANCONG
values ('1007','11/1/2000','991')
insert into PHANCONG
values ('1007','10/31/2000','206')
go


