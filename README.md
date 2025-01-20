## Шаги
1. Создал Dockerfile
2. Сбилдил с указанием тега: "docker build -t kuber_app:1.0.0 ."
3. Запустил "docker run -d -p 8000:8000 kuber_app:1.0.0" и проверил "curl http://localhost:8000/hello.html
". Content="Hello world"
4. Запушил образ в Docker Hub "docker tag kuber_app:1.0.0 nickbut/kuber_app:1.0.0" -> "docker push nickbut/kuber_app:1.0.0"
5. Создал delpoyment.yaml
6. Применил его "kubectl apply -f deployment.yaml"
7. Проверил работу "kubectl get pods"
8. Создал service.yaml
9. Применил "kubectl apply -f service.yaml"
10. Нашел Node IP "kubectl get nodes -o wide"
11. http://<Node_IP>:30007/hello.html - А вот тут у меня ничего не робит. Просто ничего не отдает, хотя (как я понял), должно "Hello world"

Посмотрел логи подов, там livenessProbe говорит, что все 200.

## Результат "kubectl describe deployment web"

"""
- Name:                   web
- Namespace:              default
- CreationTimestamp:      Mon, 20 Jan 2025 21:49:56 +0300
- Labels:                 <none>
- Annotations:            deployment.kubernetes.io/revision: 1
- Selector:               app=web
- Replicas:               2 desired | 2 updated | 2 total | 2 available | 0 unavailable
- StrategyType:           RollingUpdate
- MinReadySeconds:        0
- RollingUpdateStrategy:  25% max unavailable, 25% max surge
- Pod Template:
  - Labels:  app=web
  - Containers:
   - web-server:
    - Image:        nickbut/kuber_app:1.0.0
    - Port:         8000/TCP
    - Host Port:    0/TCP
    - Liveness:     http-get http://:8000/hello.html delay=5s timeout=1s period=10s #success=1 #failure=3
    - Environment:  <none>
    - Mounts:       <none>
  - Volumes:        <none>
- Conditions:
  Type           Status  Reason
  ----           ------  ------
  - Available      True    MinimumReplicasAvailable
  - Progressing    True    NewReplicaSetAvailable
- OldReplicaSets:  <none>
- NewReplicaSet:   web-75c5596c99 (2/2 replicas created)
- Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
- Normal  ScalingReplicaSet  5m17s  deployment-controller  Scaled up replica set web-75c5596c99 to 2

"""

## Результат "kubectl describe service web"

"""
- Name:                     web 
- Namespace:                default
- Labels:                   <none>
- Annotations:              <none>
- Selector:                 app=web
- Type:                     NodePort
- IP Family Policy:         SingleStack
- IP Families:              IPv4
- IP:                       10.102.247.195
- IPs:                      10.102.247.195
- Port:                     <unset>  8081/TCP
- TargetPort:               8000/TCP
- NodePort:                 <unset>  30008/TCP
- Endpoints:                10.1.0.8:8000,10.1.0.9:8000
- Session Affinity:         None
- External Traffic Policy:  Cluster
- Events:                   <none>

"""

## Результат "kubectl describe service web"

НИ-...