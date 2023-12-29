--Trần Đình Khánh Đăng
--22520195
--Đề 4

SET DATEFORMAT MDY

CREATE TABLE GIANGVIEN(
	MAGV CHAR(5) PRIMARY KEY,
	HOTEN NVARCHAR(30),
	KHOA NVARCHAR(30),
	SDT CHAR(10),
	EMAIL CHAR(30)
)

CREATE TABLE SINHVIEN(
	MASV CHAR(8) PRIMARY KEY,
	HOTEN NVARCHAR(30),
	KHOA NVARCHAR(30),
	NGSINH DATETIME,
	GIOITINH NVARCHAR(3)
)

CREATE TABLE DETAI(
	MADT CHAR(5) PRIMARY KEY,
	TENDT NVARCHAR(30),
	KINHPHI FLOAT,
	HANCUOI DATETIME,
	MAGV CHAR(5),
	KETQUA NVARCHAR(15)
)

CREATE TABLE HUONGDAN(
	MAHD CHAR(5) PRIMARY KEY,
	MASV CHAR(8) NOT NULL,
	MADT CHAR(5) NOT NULL
)

ALTER TABLE HUONGDAN
ADD CONSTRAINT FK_HUONGDAN_SV FOREIGN KEY (MASV) REFERENCES SINHVIEN(MASV)

ALTER TABLE HUONGDAN
ADD CONSTRAINT FK_HUONGDAN_DT FOREIGN KEY (MADT) REFERENCES DETAI(MADT)

ALTER TABLE DETAI
ADD CONSTRAINT FK_DETAI_GV FOREIGN KEY (MAGV) REFERENCES GIANGVIEN(MAGV)

--NHAPDULIEU
INSERT INTO GIANGVIEN
VALUES ('10001',N'Hoàng Thị Thu Thu',N'Khoa Hệ thống Thông tin','0345123456','thuhht@email.com')

INSERT INTO GIANGVIEN
VALUES ('10002',N'Văn Tiến Anh',N'Khoa Kỹ thuật Máy tính','0988121211','anhvt@email.com')

INSERT INTO GIANGVIEN
VALUES ('10003',N'Nguyễn Văn Chiến',N'Khoa Khoa học Máy tính','0905000555','chiennv@email.com')

INSERT INTO GIANGVIEN
VALUES ('10004',N'Tô Đắc Kỷ',N'Khoa Hệ thống Thông tin','0123456789','kytd@email.com')

INSERT INTO SINHVIEN
VALUES ('20520003', N'Hoàng Văn Tiến', N'Khoa Hệ thống Thông tin', '03/10/2002',N'Nam')

INSERT INTO SINHVIEN
VALUES ('20520004', N'Đỗ Văn Thịnh', N'Khoa Kỹ thuật Máy tính', '11/19/2002',N'Nam')

INSERT INTO SINHVIEN
VALUES ('21520001', N'Hoàng Tiến An', N'Khoa Khoa học Máy tính', '08/15/2003',N'Nam')

INSERT INTO SINHVIEN
VALUES ('21520003', N'Nguyễn Thanh Tâm', N'Khoa Kỹ thuật Máy tính', '01/20/2003',N'Nữ')

INSERT INTO SINHVIEN
VALUES ('22520002', N'Lê Hoàng Nhật Thảo', N'Khoa Khoa học Máy tính', '01/15/2004',N'Nam')

INSERT INTO SINHVIEN
VALUES ('22520004', N'Đỗ Hoàng Dũng', N'Khoa Kỹ thuật Máy tính', '03/30/2004',N'Nam')

INSERT INTO SINHVIEN
VALUES ('23520001', N'Đinh Tiến Đạt', N'Khoa Khoa học Máy tính', '01/19/2005',N'Nam')

INSERT INTO DETAI
VALUES ('DT001',N'Xây dựng sàn thương mại', 10000000,'10/10/2023','10001',N'Đạt')

INSERT INTO DETAI
VALUES ('DT002',N'Xây dựng website', 4000000,'10/15/2023','10002',N'Không đạt')

INSERT INTO DETAI
VALUES ('DT003',N'Xây dựng hệ thống điểm danh', 7000000,'11/21/2023','10003',N'Đạt')

INSERT INTO DETAI
VALUES ('DT004',N'Nghiên cứu xe tự hành', 11000000,'12/29/2023','10004',N'Chưa nghiệm thu')

INSERT INTO HUONGDAN
VALUES ('00001','20520003','DT001')

INSERT INTO HUONGDAN
VALUES ('00002','20520004','DT002')

INSERT INTO HUONGDAN
VALUES ('00003','21520001','DT003')

INSERT INTO HUONGDAN
VALUES ('00004','21520003','DT004')

INSERT INTO HUONGDAN
VALUES ('00005','22520002','DT001')

INSERT INTO HUONGDAN
VALUES ('00006','22520004','DT002')

INSERT INTO HUONGDAN
VALUES ('00007','23520001','DT003')

INSERT INTO HUONGDAN
VALUES ('00008','23520001','DT004')

INSERT INTO HUONGDAN
VALUES ('00009','21520001','DT001')

INSERT INTO HUONGDAN
VALUES ('00010','20520003','DT002')

--2. Cài đặt trigger cho các ràng buộc toàn vẹn sau
	--a. Mỗi đề tài chỉ có 1 giảng viên hướng dẫn
CREATE TRIGGER SL_GV_PER_DETAI
ON DETAI
FOR INSERT
AS
BEGIN
	DECLARE @SLGV INT
	SELECT @SLGV = COUNT(i.MAGV) FROM Inserted i, DETAI DT WHERE i.MAGV = DT.MAGV
	IF(@SLGV > 1)
		BEGIN
			PRINT(N'Mỗi đề tài chỉ có 1 giảng viên hướng dẫn')
			ROLLBACK TRAN
		END
		ELSE
		BEGIN
			PRINT(N'Đã thêm thành công')
		END
END

	--b. Sinh viên khoa nào thì do giảng viên khoa đó hướng dẫn

CREATE TRIGGER COLLEAGUE_ASSISTANT_CONDITION
ON HUONGDAN
FOR INSERT
AS
BEGIN
	IF EXISTS (SELECT * FROM INSERTED I, HUONGDAN HD, DETAI DT, GIANGVIEN GV, SINHVIEN SV
	WHERE I.MAHD = HD.MAHD AND SV.MASV = HD.MASV AND I.MADT = DT.MADT AND DT.MAGV = GV.MAGV AND GV.KHOA != SV.KHOA)
	BEGIN
		PRINT(N'Sinh viên nào thì do giảng viên khoa đó hướng dẫn')
	END
	ELSE
	BEGIN
		PRINT(N'Đã thêm thành công')
	END
END

--3. Viết các lệnh sql thực hiện các truy vấn sau
	--a. Tìm danh sách các hướng dẫn chưa nghiệm thu, sắp xếp theo chiều tăng dần MSV

SELECT MAHD, MASV, DT.MADT 
FROM HUONGDAN HD, DETAI DT
WHERE HD.MADT = DT.MADT AND KETQUA = N'Chưa nghiệm thu'

	--b. Cho biết tên các bạn sinh viên khoa HỆ THỐNG THÔNG TIN tham gia đề tài và được nghiệm thu là Đạt

SELECT HOTEN AS N'Họ tên sinh viên' 
FROM SINHVIEN SV, HUONGDAN HD, DETAI DT
WHERE SV.MASV = HD.MASV AND HD.MADT = DT.MADT AND KETQUA = N'Đạt' AND KHOA = N'Khoa Hệ thống Thông tin'

	--c. Tính tổng kinh phí thực hiện của các đề tài cho sinh viên khoa Hệ thống Thông tin thực hiện

SELECT SUM(KINHPHI) TONG_KINH_PHI
FROM SINHVIEN SV, HUONGDAN HD, DETAI DT
WHERE HD.MASV = SV.MASV AND DT.MADT = HD.MADT AND KHOA = N'Khoa Hệ thống Thông tin'

	--d. Cho biết mã và họ tên của giảng viên hướng dẫn các đề tài có 2 sinh viên trở lên tham gia

SELECT GV.MAGV, HOTEN AS N'Họ tên giảng viên'
FROM GIANGVIEN GV
WHERE EXISTS 
	(SELECT GV.MAGV, COUNT(HD.MASV) FROM GIANGVIEN GV, HUONGDAN HD, DETAI DT
			WHERE GV.MAGV = DT.MAGV AND HD.MADT = DT.MADT
			GROUP BY GV.MAGV
			HAVING COUNT(HD.MASV) >= 2
	)

	--e. Tìm giảng viên (Mã giảng viên, tên giảng viên) hướng dẫn nhiều đề tài nhất có kinh phí lớn hơn 10 triệu

SELECT TOP 1 WITH TIES GV.MAGV, HOTEN AS N'Tên giảng viên' 
FROM GIANGVIEN GV, HUONGDAN HD, DETAI DT
WHERE GV.MAGV = DT.MAGV AND KINHPHI > 10000000
GROUP BY GV.MAGV, HOTEN
ORDER BY COUNT(GV.MAGV) DESC

	--f. Tìm giảng viên hướng dẫn đề tài có kinh phí là cao nhất và vẫn chưa nghiệm thu 

SELECT GV.MAGV, HOTEN AS N'Tên giảng viên' 
FROM GIANGVIEN GV, DETAI DT
WHERE GV.MAGV = DT.MAGV AND KETQUA = N'Chưa nghiệm thu'
AND KINHPHI = (SELECT TOP 1 WITH TIES KINHPHI FROM DETAI
				GROUP BY KINHPHI
				ORDER BY KINHPHI DESC
			)