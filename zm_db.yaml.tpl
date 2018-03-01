apiVersion: v1
kind: Service
metadata:
  name: zm-db
  labels:
    app: zm-db
spec:
  ports:
  - name: zm-db
    protocol: TCP
    port: 3306
    targetPort: 3306
    #nodePort: 33306
  type: NodePort
  selector:
    app: zm-db
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: zm-db
spec:
  replicas: 1
  selector:
    matchLabels:
      app: zm-db
  template:
    metadata:
      labels:
        app: zm-db
    spec:
      containers:
      - name: zm-db
        image: thisistom/zm_database:v1.30.4
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: zoneminder
        ports:
        - containerPort: 3306
        securityContext:
          privileged: true
