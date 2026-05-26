# Missort alert logic

MISSORT_THRESHOLD = 5

def check_missort_rate(missort_rate):

    if missort_rate > MISSORT_THRESHOLD:
        return {
            "alert": True,
            "message": f"Warning: Missort rate is {missort_rate}%"
        }

    return {
        "alert": False,
        "message": "Missort rate normal"
    }


#print(check_missort_rate(3))
#print(check_missort_rate(7))
test_rates = [3,7]

for rate in test_rates:
    print(check_missort_rate(rate))