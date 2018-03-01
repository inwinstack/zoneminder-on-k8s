apiVersion: v1
kind: Service
metadata:
  name: zm-nfs
  labels:
    app: zm-nfs
spec:
  ports:
  - name: zm-nfs
    protocol: TCP
    port: 2049
    targetPort: 2049
    #nodePort: 32049
  type: NodePort
  selector:
    app: zm-nfs
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: zm-nfs
  labels:
    app: zm-nfs
spec:
  replicas: 1
  selector:
    matchLabels:
      app: zm-nfs
  template:
    metadata:
      labels:
        app: zm-nfs
    spec:
      containers:
      - name: zm-nfs
        image: thisistom/centos7-nfs-smb:v1.0
        command:
        env:
        - name: SMB_SERVER
          value: "_SMB_SERVER_"
        - name: NFS_SERVER
          value: "_NFS_SERVER_"
        ports:
        - containerPort: 2049
        securityContext:
          privileged: true
        volumeMounts:
        - mountPath: "_DOCKER_PATH_"
          name: nfs-dir
      volumes:
      - name: nfs-dir
        hostPath:
          path: "_HOST_PATH_"
          type: Directory
