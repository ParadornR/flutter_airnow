import requests
import json
import time

API_KEY = "a4547916-d95f-4d43-b0ef-3bcdc2bf1011"  # 🔑 เปลี่ยนตรงนี้ให้เป็น API Key ของคุณ

# อ่านไฟล์ countries.json
with open("countries.json", "r", encoding="utf-8") as f:
    raw_data = json.load(f)

# ดึงชื่อประเทศจาก key "data"
countries = [entry["country"] for entry in raw_data["data"]]

# เก็บผลลัพธ์
result = {}

# ฟังก์ชันตรวจสอบ Response เมื่อ API มี Rate Limit
def handle_rate_limit(response):
    # หาก response บอกว่า rate limit เกิน
    if response.status_code == 429:  # HTTP 429: Too Many Requests
        print("🔴 Rate limit exceeded, กำลังรอ 60 วินาที...")
        time.sleep(60)  # รอ 60 วินาที (สามารถปรับให้เหมาะสม)
        return True
    return False

# ลูปเรียก API ทีละประเทศ
for i, country in enumerate(countries, 1):
    print(f"[{i}/{len(countries)}] กำลังดึงข้อมูลของประเทศ: {country}")
    url = f"https://api.airvisual.com/v2/states?country={country}&key={API_KEY}"

    try:
        response = requests.get(url)

        # ถ้า rate limit เกิน ให้รอแล้วลองใหม่
        while handle_rate_limit(response):
            response = requests.get(url)

        data = response.json()

        if data.get("status") == "success":
            states = [state["state"] for state in data["data"]]
            result[country] = states
        else:
            print(f"❌ ดึงข้อมูลไม่สำเร็จ: {country} -> {data.get('data')}")
            result[country] = []

    except Exception as e:
        print(f"⚠️ เกิดข้อผิดพลาดกับ {country}: {e}")
        result[country] = []

    time.sleep(2)  # เพิ่มเวลาระหว่างการเรียก API (สามารถปรับตาม rate limit ของ API)

# บันทึกลงไฟล์ JSON
with open("countries_with_states.json", "w", encoding="utf-8") as f:
    json.dump(result, f, ensure_ascii=False, indent=2)

print("\n✅ บันทึกเรียบร้อยแล้วที่ 'countries_with_states.json'")
