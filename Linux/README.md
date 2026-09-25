# DevOps Assignment — Commands

## 2. Create a Linux user `PS` with primary group `PSgroup` and secondary group `dba`

```bash
sudo groupadd PSgroup
sudo groupadd dba
sudo useradd -g PSgroup PS
sudo usermod -aG dba PS
```

Verify:

```bash
id PS
```

## 3. Modify the root password

```bash
sudo passwd root
```

## 4. Install MySQL DB Engine and HAProxy on the Linux VM

```bash
sudo apt update
sudo apt install mysql-server -y
sudo apt install haproxy -y
```

## 5. Allow TCP/UDP traffic only on port 3306 using firewall services and commands

```bash
sudo ufw allow 3306/tcp
sudo ufw allow 3306/udp
sudo ufw status
```

## 6. Copy a file from your local machine to the VM using FTP tools or command line

Example using `scp` (over SSH):

```bash
echo "Hello from my local machine" > test.txt
scp test.txt vboxuser@192.168.1.181:/home/vboxuser/
```