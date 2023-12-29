﻿CREATE TABLE GIANGVIEN(
    MAGV CHAR(5),
    HOTEN NVARCHAR(20),
    EMAIL VARCHAR(20),
    CONSTRAINT PK_GIANGVIEN PRIMARY KEY (MAGV)
)

CREATE TABLE SINHVIEN(
    MASV CHAR(8),
    HOTEN NVARCHAR(20),
    NGSINH DATETIME,
    GIOITINH NVARCHAR(3),
    CONSTRAINT PK_SINHVIEN PRIMARY KEY (MASV)
)

CREATE TABLE MONTHI(
    MAMON CHAR(5),
    TENMON NVARCHAR(20),
    NGAYTHI DATETIME,
    PHONGTHI CHAR(5),
    MAGV CHAR(5),
    CONSTRAINT PK_MONTHI PRIMARY KEY (MAMON),
    CONSTRAINT FK_MONTHI FOREIGN KEY (MAGV) REFERENCES GIANGVIEN(MAGV)
)

CREATE TABLE DIEM(
    MASV CHAR(8),
    MAMON CHAR(5),
    DIEM FLOAT,
    CONSTRAINT PK_DIEM PRIMARY KEY (MASV, MAMON),
    FOREIGN KEY (MASV) REFERENCES SINHVIEN(MASV),
    FOREIGN KEY (MAMON) REFERENCES MONTHI(MAMON)
)

SET DATEFORMAT DMY;

INSERT INTO MONTHI VALUES('IT001', N'Nhập môn lập trình',	'29/12/2022', 'B1.02', '80001')
INSERT INTO MONTHI VALUES('IT002', N'Hướng đối tượng',	'30/12/2022', 'B1.04', '80002')
INSERT INTO MONTHI VALUES('IT003', N'Cấu trúc dữ liệu', '02/01/2023', 'B1.06', '80003')
INSERT INTO MONTHI VALUES('ENG01', N'Anh văn 1', '03/01/2022', 'B1.08', '80004')
INSERT INTO MONTHI VALUES('ENG02', N'Anh văn 2', '04/01/2022', 'B1.02', '80005')
INSERT INTO MONTHI VALUES('MA001', N'Toán cao cấp', '05/01/2022', 'B1.04', '80006')

SELECT * FROM MONTHI

INSERT INTO SINHVIEN VALUES('09521001', N'Đinh Bá Tiên', '11/02/2000', 'Nam')
INSERT INTO SINHVIEN VALUES('09521002', N'Nguyễn Thanh Tùng', '20/08/2000', 'Nam')
INSERT INTO SINHVIEN VALUES('09521003', N'Bùi Ngọc Hằng', '11/3/1999', N'Nữ')
INSERT INTO SINHVIEN VALUES('09521004', N'Lê Mạnh Quỳnh', '01/02/2000', N'Nữ')
INSERT INTO SINHVIEN VALUES('09521005', N'Nguyễn Mạnh Hùng', '04/05/2000', 'Nam')
INSERT INTO SINHVIEN VALUES('09521006', N'Trần Thanh Tâm', '19/10/2000', 'Nam')
INSERT INTO SINHVIEN VALUES('09521007', N'Trần Hồng Quang', '21/12/2000', 'Nam')

INSERT INTO DIEM VALUES('09521001', 'IT001', 7)
INSERT INTO DIEM VALUES('09521002', 'IT001', 8)
INSERT INTO DIEM VALUES('09521003', 'IT001', 9)
INSERT INTO DIEM VALUES('09521004', 'IT001', 9)
INSERT INTO DIEM VALUES('09521005', 'IT001', 8)
INSERT INTO DIEM VALUES('09521006', 'IT001', 9)
INSERT INTO DIEM VALUES('09521007', 'IT001', 10)
INSERT INTO DIEM VALUES('09521003', 'IT002', 6)
INSERT INTO DIEM VALUES('09521004', 'IT002', 7)
INSERT INTO DIEM VALUES('09521005', 'IT002', 8)
INSERT INTO DIEM VALUES('09521006', 'IT002', 9)
INSERT INTO DIEM VALUES('09521004', 'IT003', 10)
INSERT INTO DIEM VALUES('09521005', 'IT003', 9)
INSERT INTO DIEM VALUES('09521006', 'IT003', 8)
INSERT INTO DIEM VALUES('09521007', 'IT003', 10)
INSERT INTO DIEM VALUES('09521001', 'ENG01', 5)
INSERT INTO DIEM VALUES('09521002', 'ENG01', 6)
INSERT INTO DIEM VALUES('09521003', 'ENG01', 8)
INSERT INTO DIEM VALUES('09521004', 'ENG01', 7)
INSERT INTO DIEM VALUES('09521005', 'ENG02', 8)
INSERT INTO DIEM VALUES('09521006', 'ENG02', 6)
INSERT INTO DIEM VALUES('09521007', 'ENG02', 7)
INSERT INTO DIEM VALUES('09521001', 'MA001', 6)
INSERT INTO DIEM VALUES('09521002', 'MA001', 7)
INSERT INTO DIEM VALUES('09521003', 'MA001', 6)
INSERT INTO DIEM VALUES('09521004', 'MA001', 7)
INSERT INTO DIEM VALUES('09521005', 'MA001', 8)
INSERT INTO DIEM VALUES('09521006', 'MA001', 7)
INSERT INTO DIEM VALUES('09521007', 'MA001', 8)

INSERT INTO GIANGVIEN VALUES('80001', N'Phạm Văn Vinh', 'vinhpv@mail.com')
INSERT INTO GIANGVIEN VALUES('80002', N'Hoàng Xuân An', 'anxh@mail.com')
INSERT INTO GIANGVIEN VALUES('80003', N'Nguyễn Tiến Thịnh', 'thinhnt@mail.com')
INSERT INTO GIANGVIEN VALUES('80004', N'Đỗ Đình Quang', 'quangdd@mail.com')
INSERT INTO GIANGVIEN VALUES('80005', N'Nguyễn Tấn Hùng', 'hungnt@mail.com')
INSERT INTO GIANGVIEN VALUES('80006', N'Lê Văn Độ', 'dolv@mail.com')

SELECT * FROM DIEM
SELECT * FROM SINHVIEN
SELECT * FROM GIANGVIEN
SELECT * FROM MONTHI

DROP TABLE DIEM
DROP TABLE SINHVIEN
DROP TABLE GIANGVIEN
DROP TABLE MONTHI
--2.	Cài đặt trigger cho các ràng buộc toàn vẹn sau:
	--a.	Mỗi giảng viên chỉ được ra đề duy nhất 01 môn thi. (1đ)
CREATE TRIGGER SL_DE_THI_GIOI_HAN ON MONTHI 
FOR INSERT
AS
BEGIN
	IF(SELECT COUNT(*) FROM MONTHI MT, INSERTED I
	WHERE MT.MAGV = I.MAGV) > 1
	BEGIN
		PRINT 'ERROR: MOI GV CHI DUOC RA DE 1 MON'
	END
	ELSE
	BEGIN
		PRINT 'MON HOC DA DUOC THEM THANH CONG'
	END
END

DROP TRIGGER SL_DE_THI_GIOI_HAN
	--b.	Mỗi sinh viên chỉ được thi tối đa 04 môn thi. (1đ)
CREATE TRIGGER SL_MON_THI_TOI_DA ON DIEM
FOR INSERT
AS 
BEGIN
	IF(SELECT COUNT(*) FROM DIEM D, INSERTED I 
	WHERE D.MASV = I.MASV) > 4
	BEGIN
		PRINT 'ERROR: MOI SV CHI DUOC THI TOI DA 4 MON'
	END
	ELSE
	BEGIN
		PRINT 'DA THEM THANH CONG'
	END
END

INSERT INTO DIEM VALUES('09521003', 'ENG002', 10)

--3.	Viết các câu lệnh SQL thực hiện các truy vấn sau:
	--a.	Tìm tên các môn thi do Giảng viên “Nguyễn Văn A” ra đề. (1đ)
SELECT TENMON FROM MONTHI MT, GIANGVIEN GV 
WHERE GV.MAGV = MT.MAGV AND GV.HOTEN = N'Nguyễn Văn A'
	--b.	Tìm sinh viên có điểm thi môn Anh văn 1 cao nhất. (1.5đ)
SELECT TOP 1 WITH TIES SV.MASV, HOTEN FROM DIEM D, SINHVIEN SV, MONTHI MT
WHERE SV.MASV = D.MASV AND D.MAMON = MT.MAMON AND MT.TENMON = N'Anh văn 1'
ORDER BY DIEM DESC
	--c.	Tìm môn thi có nhiều sinh viên thi nhất. (1.5đ)
SELECT TOP 1 WITH TIES MT.MAMON, TENMON
FROM MONTHI MT, DIEM D
WHERE MT.MAMON = D.MAMON
GROUP BY MT.MAMON, TENMON
ORDER BY COUNT(D.MASV) DESC
	--d.	Danh sách các sinh viên có điểm thi tất cả các môn trên 8đ (1.5đ)

	SELECT SV.MASV, HOTEN, MT.MAMON, D.DIEM
	FROM SINHVIEN SV, DIEM D, MONTHI MT
	WHERE D.MAMON = MT.MAMON AND D.MASV = SV.MASV 
	GROUP BY SV.MASV, HOTEN, MT.MAMON, D.DIEM
	ORDER BY MT.MAMON 

	SELECT HOTEN, SV.MASV FROM SINHVIEN SV
	WHERE NOT EXISTS(
		SELECT * FROM MONTHI MT
		WHERE NOT EXISTS(
			SELECT * FROM DIEM D
			WHERE D.MAMON = MT.MAMON AND D.MASV = SV.MASV AND D.DIEM > 8
		)
	)

