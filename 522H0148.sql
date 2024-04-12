USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QLBH')
BEGIN
    ALTER DATABASE QLBH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE QLBH;
END
create database QLBH
use QLBH
go
--tao bang NguoiDung
CREATE TABLE NguoiDung(
    IDNguoiDung Varchar(100) PRIMARY KEY,
    HoVaTen VARCHAR(255),
    Gmail VARCHAR(255),
    SDT VARCHAR(15)
);
--tao bang NguoiDungThanThiet
CREATE TABLE NguoiDungThanThiet(
    IDNguoiDung Varchar(100) PRIMARY KEY,
    DACQUYEN VARCHAR(255),
    FOREIGN KEY (IDNguoiDung) REFERENCES NguoiDung(IDNguoiDung)
);
--tao bang NguoiDungMoi
CREATE TABLE NguoiDungMoi(
    IDNguoiDung Varchar(100) PRIMARY KEY,
    HANCHEN VARCHAR(255),
    FOREIGN KEY (IDNguoiDung) REFERENCES NguoiDung(IDNguoiDung)
);
--tao bang Game
CREATE TABLE Game(
    IDGame Varchar(100) PRIMARY KEY,
    TenGame VARCHAR(255),
    GiaCa DECIMAL(10, 2)
);
--tao bang GiaoDich
CREATE TABLE GiaoDich(
    IDGiaoDich Varchar(100) PRIMARY KEY,
    NgayGiaoDich DATE,
    IDNguoiDung Varchar(100),
    IDGame Varchar(100),
    FOREIGN KEY (IDNguoiDung) REFERENCES NguoiDung(IDNguoiDung),
    FOREIGN KEY (IDGame) REFERENCES Game(IDGame)
);
--tao bang WishList
CREATE TABLE WishList(
    IDWishList Varchar(100) PRIMARY KEY,
    NgayThem DATE,
    IDNguoiDung Varchar(100),
    IDGame Varchar(100),
    FOREIGN KEY (IDNguoiDung) REFERENCES NguoiDung(IDNguoiDung),
    FOREIGN KEY (IDGame) REFERENCES Game(IDGame)
);
--tao bang DanhGia
CREATE TABLE DanhGia(
    IDDanhGia Varchar(100) PRIMARY KEY,
    BinhLuan TEXT,
    DiemDanhGia INT,
    IDNguoiDung Varchar(100),
    IDGame Varchar(100),
    FOREIGN KEY (IDNguoiDung) REFERENCES NguoiDung(IDNguoiDung),
    FOREIGN KEY (IDGame) REFERENCES Game(IDGame)
);
--tao bang TheLoai
CREATE TABLE TheLoai(
    IDTheLoai Varchar(100) PRIMARY KEY,
    TenTheLoai VARCHAR(255)
);
--tao bang NhaPhatTrien
CREATE TABLE NhaPhatTrien(
    IDNhaPhatTrien Varchar(100) PRIMARY KEY,
    TenNhaPhatTrien VARCHAR(255),
    TuoiDoi INT
);
--tao bang DiaChi
CREATE TABLE DiaChi(
    Duong VARCHAR(255),
    ThanhPho VARCHAR(255),
    QuocGia VARCHAR(255),
    IDNhaPhatTrien Varchar(100),
    FOREIGN KEY (IDNhaPhatTrien) REFERENCES NhaPhatTrien(IDNhaPhatTrien)
);
--tao bang Thue
CREATE TABLE Thue(
    IDThue Varchar(100) PRIMARY KEY,
    LoaiThue VARCHAR(255),
    TiLe DECIMAL(5, 2),
    IDNhaPhatTrien Varchar(100),
    FOREIGN KEY (IDNhaPhatTrien) REFERENCES NhaPhatTrien(IDNhaPhatTrien)
);

--thêm dữ liệu vào các bảng
INSERT INTO NguoiDung(IDNguoiDung, HoVaTen, Gmail, SDT)
VALUES 
('ND1101','Long Nguyen','LongA1@gmail.com','0233452223'),
('ND1102','Tran Thanh Thien','ThanhCute12@gmail.com','0913235262'),
('ND1103','Van Phap','PhapVan@gmail.com','0918483439'),
('ND1104','Nguyen Anh Dung', 'NAD@gmail.com','0375537901'),
('ND1105','Ngyen Chi Cong', 'CongTinh223@gmail.com','0908395590');

INSERT INTO NguoiDungThanThiet(IDNguoiDung, DACQUYEN)
VALUES 
('ND1101', 'giảm giá 30% mỗi tháng 2 game'),
('ND1102', 'CSKH sẽ được ưu tiên'),
('ND1103', 'giảm giá 99% mỗi tháng 1 game');

INSERT INTO NguoiDungMoi(IDNguoiDung, HANCHEN)
VALUES 
('ND1104', 'CSKH sẽ không được ưu tiên'),
('ND1105', 'Không thể mua game tặng bạn bè');

INSERT INTO Game(IDGame, TenGame, GiaCa)
VALUES 
('G301', 'The Legend of Zelda', 120.00),
('G302', 'Mario Kart 3', 50.00),
('G303', 'The last of us I', 110.00),
('G304', 'Than Trung', 79.00),
('G305', 'Layers of Fear', 88.00);

INSERT INTO GiaoDich(IDGiaoDich, NgayGiaoDich, IDNguoiDung, IDGame)
VALUES 
('GD0001', '2022-01-01', 'ND1101', 'G301'),
('GD0002', '2022-01-02', 'ND1102', 'G302'),
('GD0003', '2022-01-03', 'ND1103', 'G303'),
('GD0004', '2022-01-04', 'ND1104', 'G304'),
('GD0005', '2022-01-05', 'ND1105', 'G305');

INSERT INTO WishList(IDWishList, NgayThem, IDNguoiDung, IDGame)
VALUES 
('WL001', '2022-01-01', 'ND1101', 'G301'),
('WL002', '2022-01-02', 'ND1102', 'G302'),
('WL003', '2022-01-03', 'ND1103', 'G303'),
('WL004', '2022-01-04', 'ND1104', 'G304'),
('WL005', '2022-01-05', 'ND1105', 'G305');

INSERT INTO DanhGia(IDDanhGia, BinhLuan, DiemDanhGia, IDNguoiDung, IDGame)
VALUES 
('DG001', 'Game hay', 5, 'ND1101', 'G301'),
('DG002', 'Game tuyệt vời', 4, 'ND1102', 'G302'),
('DG003', 'Game khá ổn', 3, 'ND1103', 'G303'),
('DG004', 'Game rất hay, ủng hộ VN', 2, 'ND1104', 'G304'),
('DG005', 'Game không hay', 1, 'ND1105', 'G305');

INSERT INTO TheLoai(IDTheLoai, TenTheLoai)
VALUES 
('TL001','Phiêu lưu'),
('TL002','Hành động'),
('TL003','Hành động'),
('TL004','Kinh dị'),
('TL005','Kinh dị');

INSERT INTO NhaPhatTrien(IDNhaPhatTrien, TenNhaPhatTrien, TuoiDoi)
VALUES 
('NPT0102','Nitendo',10),
('NPT0103','MSD',13),
('NPT0104','Hutmau',12),
('NPT0105','Dut Studio',2),
('NPT0106','FromSoftWare',8);

INSERT INTO DiaChi(Duong, ThanhPho, QuocGia, IDNhaPhatTrien)
VALUES 
('balu hu', 'Hanoi', 'Japan', 'NPT0102'),
('thanh tri', 'New York', 'USA', 'NPT0103'),
('noi bai', 'Tokyo', 'Japan', 'NPT0104'),
('tan san nhat', 'Seoul', 'Korea', 'NPT0105'),
('hoang kiem', 'Beijing', 'China', 'NPT0106');

INSERT INTO Thue(IDThue, LoaiThue, TiLe, IDNhaPhatTrien)
VALUES 
('Th001', 'VAT', 0.10, 'NPT0102'),
('Th002', 'VAT', 0.20, 'NPT0103'),
('Th003', 'VAT', 0.20, 'NPT0104'),
('Th004', 'VAT', 0.30, 'NPT0105'),
('Th005', 'VAT', 0.10, 'NPT0106');

--test thử coi insert dữ liệu có thành công không
select * from NguoiDung;
select * from NguoiDungThanThiet;
select * from NguoiDungMoi;
select * from Game;
select * from GiaoDich;
select * from WishList;
select * from DanhGia;
select * from TheLoai;
select * from NhaPhatTrien;
select * from DiaChi;
select * from Thue;

--FUNCTION1
Go
CREATE FUNCTION ThemIDmoi()
RETURNS NVARCHAR(255) AS
BEGIN
    DECLARE @IDhientai NVARCHAR(255);
    DECLARE @LuuID NVARCHAR(255);
    DECLARE @IDmoi NVARCHAR(255);

    SELECT @IDhientai = MAX(IDNguoiDung) FROM NguoiDung;
    SELECT @IDmoi = 'ND'+RIGHT(REPLICATE('0',4)+CAST(CAST(SUBSTRING(@IDhientai,3,LEN(@IDhientai)-2) AS INT)+1 AS NVARCHAR(4)),4);

    RETURN @IDmoi;
END;
GO

--c1 thêm trực tiếp
INSERT INTO NguoiDung(IDNguoiDung, HoVaTen, Gmail, SDT)
VALUES (dbo.ThemIDmoi(), 'Chí Long Nguyen', 'LongAASS@gmail.com', '0909121322');
select * from NguoiDung;

--c2 dùng procedure
Go
CREATE PROCEDURE ThemNguoiDung
    @HoVaTen NVARCHAR(255),
    @Gmail NVARCHAR(255),
    @SDT NVARCHAR(20)
AS
BEGIN
    DECLARE @IDNguoiDung NVARCHAR(255);
    SET @IDNguoiDung = dbo.ThemIDmoi();

    INSERT INTO NguoiDung(IDNguoiDung, HoVaTen, Gmail, SDT)
    VALUES (@IDNguoiDung, @HoVaTen, @Gmail, @SDT);
END;
Go

--run proc
EXEC ThemNguoiDung 'Chí Đạt', 'ĐatDamDang@gmail.com', '0909333330';
select * from NguoiDung;

--FUNCTUON 2
Go
CREATE FUNCTION ThemIDNPT()
RETURNS NVARCHAR(255) AS
BEGIN
    DECLARE @IDhientai NVARCHAR(255);
    DECLARE @IDmoi NVARCHAR(255);

    SELECT @IDhientai = MAX(IDNhaPhatTrien) FROM NhaPhatTrien;
    SELECT @IDmoi = 'NPT'+RIGHT(REPLICATE('0',4) + CAST(CAST(SUBSTRING(@IDhientai,4,LEN(@IDhientai)-3) AS INT)+1 AS NVARCHAR(4)),4);

    RETURN @IDmoi;
END;
GO

--c1 thêm trực tiếp
--INSERT INTO NhaPhatTrien(IDNhaPhatTrien, TenNhaPhatTrien, TuoiDoi)
INSERT INTO NhaPhatTrien(IDNhaPhatTrien, TenNhaPhatTrien, TuoiDoi)
VALUES (dbo.ThemIDNPT(), 'Betesda', 9);

select * from NhaPhatTrien;
--c2 dùng procedure
Go
CREATE PROCEDURE ThemNhaPhatTrien
    @TenNhaPhatTrien NVARCHAR(255),
    @TuoiDoi INT
AS
BEGIN
    DECLARE @IDNhaPhatTrien NVARCHAR(255);
    SET @IDNhaPhatTrien = dbo.ThemIDNPT();

    INSERT INTO NhaPhatTrien(IDNhaPhatTrien, TenNhaPhatTrien, TuoiDoi)
    VALUES (@IDNhaPhatTrien, @TenNhaPhatTrien, @TuoiDoi);
END;
GO

--run proc
EXEC ThemNhaPhatTrien 'Nexus Time', 21;
select * from NhaPhatTrien;


--Tạo trigger rằng buộc DanhGia
Go
CREATE TRIGGER CheckConstraints_DanhGia
ON DanhGia
AFTER INSERT, UPDATE
AS
BEGIN
    -- Kiểm tra ràng buộc khóa ngoại
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN NguoiDung nd ON i.IDNguoiDung = nd.IDNguoiDung
        WHERE nd.IDNguoiDung IS NULL
    )
    BEGIN
        RAISERROR ('KHOÁ NGOẠI BỊ RẰNG BUỘC',16,1)
        ROLLBACK TRANSACTION
        RETURN
    END

    -- Kiểm tra ràng buộc giá trị
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.DiemDanhGia <0 OR i.DiemDanhGia >5
    )
    BEGIN
        RAISERROR ('Điểm là con số từ 0 đến 5, số ngoài phạm vi này là vi phạm!',16,1)
        ROLLBACK TRANSACTION
        RETURN
    END
END;
Go

--CHẠY THỬ
INSERT INTO DanhGia(IDDanhGia, BinhLuan, DiemDanhGia, IDNguoiDung, IDGame)
VALUES ('DG006', 'Game hay quá trời quá đất, đi crack thôi!', 6, 'ND1101', 'G301');
select * from DanhGia;
