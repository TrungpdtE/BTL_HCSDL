import re

#Tạo ra lớp thực thể(Entity)
#Em quy ước dòng cuối > là dòng mà biểu thị mối quan hệ giữa các bảng, các số cách bởi dấu - là vị trí dòng, các kí tự cách bởi dấu , là các quan hệ 1,1 1,n ,......
class ThucThe:
    def KhoiTaoThucThe(thamChieu, thuocTinh, tenThucThe):
        thamChieu.tenThucThe=tenThucThe
        thamChieu.LuuThuocTinh=thuocTinh
        thamChieu.rangBuoc=[]
        thamChieu.LuuKhoaNgoai=[LuuThuocTinh for LuuThuocTinh in thuocTinh if "<" in LuuThuocTinh]
        thamChieu.khoaChinh=[LuuThuocTinh for LuuThuocTinh in thuocTinh if "{" in LuuThuocTinh and "}" in LuuThuocTinh]
    #Hàm tìm khoá chính đó
    def TimKhoaChinh(thamChieu):
        thamChieu.khoaChinh=[LuuThuocTinh.replace("<", "").replace(">", "") for LuuThuocTinh in thamChieu.khoaChinh]
    #Hàm chỉnh sửa lại khoá chính
    def suaKhoaChinh(thamChieu):
        thamChieu.khoaChinh=[f"{{{khoachinh.replace('<', '').replace('>', '')}}}" if "<" in khoachinh else khoachinh for khoachinh in thamChieu.khoaChinh]
    #Hàm tìm khoá ngoại
    def TimKhoaNgoai(thamChieu):
        thamChieu.LuuKhoaNgoai=[LuuKhoaNgoai for LuuKhoaNgoai in thamChieu.LuuThuocTinh if "<" in LuuKhoaNgoai]
    #Hàm trả về string của thực thể
    def toString(thamChieu):
        return f"{thamChieu.tenThucThe}: {thamChieu.LuuThuocTinh} {' '.join(thamChieu.rangBuoc) if thamChieu.rangBuoc else ''}"


#Tạo ra lớp ERD
class ERD:
    #Hàm khởi tạo thực thể và quan hệ
    def __init__(thamChieu):
        thamChieu.thucThe=[]
        thamChieu.quanHe=[]

    #Hàm đọc file
    def doc(thamChieu, input):
        with open(input, 'r') as file:
            for dong in file:
                if dong.startswith(">"):
                    continue
                data=dong.strip().split(" ")
                thucTheData=data[0].split(":")
                if len(data)>1:
                    thamChieu.quanHe.extend(data[1:])
                thamChieu.themThucThe(thucTheData)
                
    #Hàm thêm thực thể
    def themThucThe(thamChieu, thucTheData):
        tenThucThe=thucTheData[0]
        thuocTinhThucThe=thucTheData[1].split(",") if len(thucTheData)>1 else []
        thucThe=ThucThe()
        thucThe.KhoiTaoThucThe(thuocTinhThucThe, tenThucThe)
        thucThe.TimKhoaChinh()
        thamChieu.thucThe.append(thucThe)

    #Hàm chuyển đổi quan hệ
    def chuyenDoiQuanHe(thamChieu):
        for quanHe in thamChieu.quanHe:
            if ":" not in quanHe:
                thamChieu.chuyenDoi1Nhieu(quanHe)
            else:
                thamChieu.chuyenDoiNhieuNhieu(quanHe)

    #Hàm chuyển đổi 1-nhiều
    def chuyenDoi1Nhieu(thamChieu, quanHe):
        quanHeData=quanHe.split("-")
        if len(quanHeData)<2:  
            return
        viTriThucThe1=int(quanHeData[0])  
        viTriThucTheNhieu=int(quanHeData[1])
        if viTriThucThe1>=len(thamChieu.thucThe) or viTriThucTheNhieu>=len(thamChieu.thucThe):
            return
        khoaChinhThucThe1=thamChieu.thucThe[viTriThucThe1].khoaChinh
        khoaChinhThucThe1=[re.sub(r"[{}]", "", f"<{key}>") for key in khoaChinhThucThe1]
        thamChieu.thucThe[viTriThucTheNhieu].LuuThuocTinh.extend(khoaChinhThucThe1)
        thamChieu.thucThe[viTriThucThe1].suaKhoaChinh()

    #Hàm chuyển đổi nhiều-nhiều
    def chuyenDoiNhieuNhieu(thamChieu, quanHe):
        quanHeData = quanHe.split("-")
        if len(quanHeData)<3:
            return
        thucTheMoiData=quanHeData[0].split(":")
        thuocTinhThucTheData=thucTheMoiData[1].split(",")
        tenThucThe=thucTheMoiData[0]
        thuocTinh=list(thuocTinhThucTheData)
        thucTheMoi=ThucThe()
        thucTheMoi.KhoiTaoThucThe(thuocTinh, tenThucThe)
        for i in range(1, 3):
            viTriThucTheNhieu=int(quanHeData[i])
            if viTriThucTheNhieu>=len(thamChieu.thucThe):
                return
            khoaChinhNhieu=thamChieu.thucThe[viTriThucTheNhieu].khoaChinh
            khoaChinhNhieu=[f"<{key}>" if "<" not in key else key for key in khoaChinhNhieu]
            thucTheMoi.LuuThuocTinh.extend(khoaChinhNhieu)
            thamChieu.thucThe[viTriThucTheNhieu].suaKhoaChinh()
        thucTheMoi.TimKhoaChinh()
        thamChieu.thucThe.append(thucTheMoi)

    #Hàm gán khoá ngoại
    def ganKhoaNgoai(thamChieu):
        for thucThe in thamChieu.thucThe:
            thucThe.TimKhoaNgoai()
            if thucThe.LuuKhoaNgoai:
                khoaNgoaiData = []
                for kn in thucThe.LuuKhoaNgoai:
                    khoaNgoaiCuoi=re.sub(r"[<>]", "", kn)
                    for thucThe in thamChieu.thucThe:
                        if khoaNgoaiCuoi in thucThe.khoaChinh and khoaNgoaiCuoi in thucThe.tenThucThe:
                            khoaNgoaiData.append(f"->{thucThe.tenThucThe}({khoaNgoaiCuoi})")
                thucThe.rangBuoc.extend(khoaNgoaiData)

    #Hàm chuyển đổi sang mô hình quan hệ
    def chuyenDoiSangMoHinhQuanHe(thamChieu):
        thamChieu.chuyenDoiNhieuThuocTinh()
        thamChieu.chuyenDoiQuanHe()
        thamChieu.ganKhoaNgoai()
        thamChieu.ghiVaoFile()

    #Hàm ghi vào file output1.txt    
    def ghiVaoFile(thamChieu):
        with open("Output1.txt", 'a') as file:  
            for thucThe in thamChieu.thucThe:
                file.write(thucThe.toString() + "\n")

    
    #Hàm chuyển đổi nhiều thuộc tính
    def chuyenDoiNhieuThuocTinh(thamChieu):
        thucTheCuaNhieuGiaTri=[]
        for thucThe in thamChieu.thucThe:
            thuocTinh=thucThe.LuuThuocTinh
            thuocTinhCuaNhieu=[]
            tenNhieu=""
            for LuuThuocTinh in thuocTinh:
                if "(" in LuuThuocTinh and ")" in LuuThuocTinh:
                    thuocTinhCuaNhieu.extend(thucThe.khoaChinh)
                    thuocTinhMoi = re.sub(r"[()]", "", LuuThuocTinh)
                    tenNhieu = thuocTinhMoi
                    thuocTinhCuaNhieu.append(f"{{{thuocTinhMoi}}}")
                    thuocTinh.remove(LuuThuocTinh)
            if thuocTinhCuaNhieu:
                thucTheCuaNhieuAtt = ThucThe()
                thucTheCuaNhieuAtt.KhoiTaoThucThe(thuocTinhCuaNhieu, thucThe.tenThucThe + tenNhieu)
                thucTheCuaNhieuAtt.TimKhoaChinh()
                thucTheCuaNhieuGiaTri.append(thucTheCuaNhieuAtt)
        if thucTheCuaNhieuGiaTri:
            thamChieu.thucThe.extend(thucTheCuaNhieuGiaTri)

    #Phân tích dòng cuối, đó là dòng biểu thị mối quan hệ giuawx các bảng
    # ở dòng cuối, các số cách bởi dấu - là vị trí dòng, các kí tự cách bởi dấu , là các quan hệ 1,1 1,n ,......
    def TachCacMQH(file):
        tachMQH = []
        with open(file, 'r') as file:
            tachDong=file.readlines()
            for dong in tachDong:
                if dong.startswith('>'): #Em quy ước dấu > biểu hiện cho dòng quan hệ
                    dong=dong[1:].strip()
                    chiaPhanRa=dong.split(' ')
                    for phan in chiaPhanRa:
                        if '-' in phan and '#' in phan:
                            tach1=phan.split('-')
                            tach2=int(tach1[0])
                            tach3=int(tach1[1].split('#')[0])
                            tach4=tach1[1].split('#')[1]
                            qh1, qh2=tach1[1].split('#')[2].split(',')
                            tachMQH.append((tach2, tach3, tach4, qh1, qh2)) #lưu các thông tin đã tách
        return tachMQH

    tachMQH = TachCacMQH('input1.txt')

    #Viết mối quan hệ giữa các bảng vào file, đặt w để nó đóng file sau khi viết xong
    with open('output1.txt', 'w') as file: 
        with open('input1.txt', 'r') as inputFile:
            tachDong = inputFile.readlines()  
        for mqh in tachMQH:
            tach1, tach2, kieuMQH, qh1, qh2 = mqh
            thucThe1=tachDong[tach1].split(':')[0]
            thucThe2=tachDong[tach2].split(':')[0]
            if(qh1=='c' and qh2=='c'): #Em quy ước c,c là quan hệ cha con
                file.write(f"[{thucThe2}]<--------------<{kieuMQH}>-------------->[{thucThe1}]\n")
            else:
                file.write(f"[{thucThe2}]<---------<{kieuMQH} ({qh1},{qh2})>--------->[{thucThe1}]\n")
        file.write('\n')

#đọc file input1.txt và chạy ERD()
erd=ERD()   
erd.doc('input1.txt')

#chuyển đổi sang mô hình quan hệ đồng thời gắn vào file output1.txt
erd.chuyenDoiSangMoHinhQuanHe()
