For the past 2 week I really just watched youtube video/did lab on kubernetes and cilium so this is my first actual status update as 2 get drop.

I created my cluster in kind following this resource https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/ aswell as this video https://www.youtube.com/watch?v=YPoXmHyGpZE&t=1009s

They give this .yaml file to create the cluster

https://raw.githubusercontent.com/cilium/cilium/1.16.3/Documentation/installation/kind-config.yaml

kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
- role: worker
networking:
  disableDefaultCNI: true

Only change I made to this was the name from kind-config.yaml to christiancluster.yaml and I added name
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
- role: worker
networking:
  disableDefaultCNI: true
name: christianrcos

https://github.com/smoleyxd/RCOS-Cilium/blob/christian/commits/clustercreate.png

I already have Cilium CLI installed so I just had to do cilium install on my cluster to get cilium to work

This shows cilium install and still not ready
https://github.com/smoleyxd/RCOS-Cilium/blob/christian/commits/ciliuminstall.png

A little bit later and all ready
https://github.com/smoleyxd/RCOS-Cilium/blob/christian/commits/clusterworking.png

Now that I had this I wanted to test an actual application and Cilium also provides a guide on getting start with Cilium with this star wars example https://docs.cilium.io/en/stable/gettingstarted/demo/

it gives this sample application with deathstar pod and tiefighter and x wing pods and it really helped me learn about communication between pods. I followed it pretty closely and did some other testing with the policy yaml they provided so it really taught me alot about writing network policies.

They give this yaml file which has the application

https://raw.githubusercontent.com/cilium/cilium/1.16.3/examples/minikube/http-sw-app.yaml

I wont include the code here since its kinda alot of lines but the link has it too and I didnt make any change to it.

https://kubernetes.io/docs/reference/kubectl/quick-reference/ Also this is a resource that really helped me

The created pods

https://github.com/smoleyxd/RCOS-Cilium/blob/christian/commits/starwardspods.png

The pods when they were ready

https://github.com/smoleyxd/RCOS-Cilium/blob/christian/commits/podsready.png

The cilium status and as you can see its managing those extra pods that were just added 7/7

https://github.com/smoleyxd/RCOS-Cilium/blob/christian/commits/cilium.png

And finally there is command -o wide for get pods that shows what nodes pods were assigned too

https://github.com/smoleyxd/RCOS-Cilium/blob/christian/commits/nodes.png

They then give this file that contains the policy

https://raw.githubusercontent.com/cilium/cilium/1.16.3/examples/minikube/sw_l3_l4_policy.yaml 

apiVersion: "cilium.io/v2"
kind: CiliumNetworkPolicy
metadata:
  name: "rule1"
spec:
  description: "L3-L4 policy to restrict deathstar access to empire ships only"
  endpointSelector:
    matchLabels:
      org: empire
      class: deathstar
  ingress:
  - fromEndpoints:
    - matchLabels:
        org: empire
    toPorts:
    - ports:
      - port: "80"
        protocol: TCP

When you dont apply this policy this is what happens when using a command they give
https://github.com/smoleyxd/RCOS-Cilium/blob/christian/commits/nopolicy.png

both the x wing and the tiefighter can land on the deathstar as nothing restricts them.

When applying their policy the x wings will be restricted because matchLabels: org: empire class: deathstar its applying to this pod from the empire with the class deathstar which we are communicating with as we are trying to land ships that only org: empire can land here.

https://github.com/smoleyxd/RCOS-Cilium/blob/christian/commits/originalpolicy.png

As you can see tiefighters can land but x wing it just doesnt do anything and you have to cancel it using ctrl + c

I then played around with this policy by just creating new yaml files using their original and here are the 2 things I did differently.

apiVersion: "cilium.io/v2"
kind: CiliumNetworkPolicy
metadata:
  name: "rule1"
spec:
  description: "L3-L4 policy to restrict deathstar access to empire ships only"
  endpointSelector:
    matchLabels:
      org: empire
      class: deathstar
  ingress:
  - fromEndpoints:
    - matchLabels:
        org: alliance
    toPorts:
    - ports:
      - port: "80"
        protocol: TCP
        
By changing the org to alliance in ingress it will only allow ships with the org alliance so it will allow xfighters and block anything else like empire with tie fighters.

https://github.com/smoleyxd/RCOS-Cilium/blob/christian/commits/testpolicy.png

apiVersion: "cilium.io/v2"
kind: CiliumNetworkPolicy
metadata:
  name: "rule1"
spec:
  description: "L3-L4 policy to restrict deathstar access to empire ships only"
  endpointSelector:
    matchLabels:
      org: empire
      class: deathstar
  ingress:
  - fromEndpoints:
    - matchLabels:
        org: hi
    toPorts:
    - ports:
      - port: "80"
        protocol: TCP

Here I just changed the org to hi since it doesnt exist within the original yaml file they gave so I thought it would block everything to the death star and it worked exactly how I wanted it to both tiefighter and xwing cant land but if there was something with an org hi then it would allow it.

https://github.com/smoleyxd/RCOS-Cilium/blob/christian/commits/testpolicy2.png

This is all I really did this week in addition to learning more about other Kubernetes related things. Im looking more into flux but I definitly feel more confident using cilium and really just with kubernetes in general.

I tried setting up Hubble but ran into some issues but hopefully I will be able to have it working for next week. 
