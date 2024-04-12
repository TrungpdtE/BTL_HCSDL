from itertools import combinations

#Bài này input của nó, em để quá nhiều ạ, dẫn đến lúc chạy chương trình sẽ rất lâu ạ,nếu được thầy nên đổi sang 1 input khác ạ
#tạo lớp phụ thuộc
class PhuThuoc:
    def __init__(thamChieu, trai, phai):
        thamChieu.trai=trai
        thamChieu.phai=phai

#Tạo hàm đọc file
def DocFile(tenFile):
    with open(tenFile, 'r') as file:
        CacDong=file.readlines()
    return CacDong

#hàm phân tích dòng
def PhanTichDong(Dong):
    LuuThuocTinh=set()
    PTH=[]
    for tungdong in Dong:
        tungdong=tungdong.strip()
        if len(LuuThuocTinh)==0:
            for phan in tungdong.split(','):
                LuuThuocTinh.add(phan.strip())
        else:
            mangluutam=tungdong.split('->')
            trai=set([phan.strip() for phan in mangluutam[0].split(',')])
            phai=set([phan.strip() for phan in mangluutam[1].split(',')])
            PTH.append(PhuThuoc(trai, phai))
    return LuuThuocTinh, PTH

#Tạo hàm kiểm tra bao đóng
def KTBaoDong(LuuThuocTinh, PTH):
    baoDong=set(LuuThuocTinh)
    cuoiCung=set()
    while baoDong!=cuoiCung:
        cuoiCung=baoDong.copy()
        for dep in PTH:
            if dep.trai.issubset(baoDong):
                baoDong.update(dep.phai)
    return baoDong

#Tạo hàm tìm khóa
def TimKhoa(LuuThuocTinh, PTH):
    kq=[]
    for i in range(1, len(LuuThuocTinh)+1):
        for keys in combinations(LuuThuocTinh, i):
            if KTBaoDong(keys, PTH)==LuuThuocTinh:
                k=set(keys)
                if not any([x.issubset(k) for x in kq]):
                    kq.append(k)
    return kq

#Tạo hàm ghi ra file
def GhiRaFile(tenFile, LuuThuocTinh, PTH, ket_qua):
    str=""
    for thuocTinh in ket_qua:
        baoDong=KTBaoDong(thuocTinh, PTH)
        str+=f"{thuocTinh} có bao đóng: {baoDong}\n"
    str+=f"{ket_qua}"
    with open(tenFile, 'w') as file:
        file.write(str)

Dong=DocFile('input2.txt')
LuuThuocTinh, PTH=PhanTichDong(Dong)
ket_qua=TimKhoa(LuuThuocTinh, PTH)
GhiRaFile('output2.txt', LuuThuocTinh, PTH, ket_qua)
