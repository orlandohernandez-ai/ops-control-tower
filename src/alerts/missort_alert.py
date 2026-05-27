# Missort alert logic

MISSORT_THRESHOLD = 5

# Missort alert logic

def check_missort_rate(missort_rate, facility, area):

    if missort_rate > 10:
        return {
            "alert": True,
            "severity": "HIGH",
            "facility": facility,
            "area": area,
            "message": f"Critical warning: Missort rate is {missort_rate}% at {facility} - {area}"
        }

    elif missort_rate > 5:
        return {
            "alert": True,
            "severity": "MEDIUM",
            "facility": facility,
            "area": area,
            "message": f"Warning: Missort rate is {missort_rate}% at {facility} - {area}"
        }

    else:
        return {
            "alert": False,
            "severity": "NORMAL",
            "facility": facility,
            "area": area,
            "message": f"Missort rate normal at {facility} - {area}"
        }


test_events = [
    {"missort_rate": 3, "facility": "Yonkers", "area": "Preload"},
    {"missort_rate": 7, "facility": "Yonkers", "area": "Primary Sort"},
    {"missort_rate": 12, "facility": "Yonkers", "area": "Outbound"}
]

for event in test_events:
    print(
        check_missort_rate(
            event["missort_rate"],
            event["facility"],
            event["area"]
        )
    )


#print(check_missort_rate(3))
#print(check_missort_rate(7))
test_rates = [3,7,12]
