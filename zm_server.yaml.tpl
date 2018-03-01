apiVersion: v1
kind: Service
metadata:
  name: zm-server1
  labels:
    app: zm-server1
spec:
  ports:
  - name: zm-server1
    protocol: TCP
    port: 80
    targetPort: 80
    nodePort: 30080
  type: NodePort
  selector:
    app: zm-server1
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: zm-server1
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: zm-server1
    spec:
      containers:
      - name: zm-server1
        image: thisistom/zm_server:v1.30.4
        env:
        - name: DB_HOST
          value: "_DB_IP_:_DB_PORT_"
        - name: NFS_MOUNT_TYPE
          value: "nfs4"
        - name: NFS_MOUNT_OPTIONS
          value: "soft,intr,tcp,rw,port=_NFS_PORT_"
        - name: NFS_ZM_PATH 
          value: "_NFS_IP_:/"
        - name: S3_BASE_HOST
          value: "_S3_BASE_HOST_"
        - name: S3_KEY
          value: "_S3_KEY_"
        - name: S3_SECRET
          value: "_S3_SECRET_"
        - name: S3_BUCKET
          value: "_S3_BUCKET_"
        ports:
        - containerPort: 80
        securityContext:
          privileged: true
      nodeSelector:
        kubernetes.io/hostname: edge
        
# to get labels of node      
# # kubectl get no --show-labels
