f=open("advent")
ids=f.readlines()
ids.sort()

for i in range(len(ids)-1):
    a=ids[i].strip()
    b=ids[i+1].strip()
    diff=0
    for c in range(len(a)):
        if a[c] != b[c]:
            diff+=1
    if diff==1:
        print a, b
