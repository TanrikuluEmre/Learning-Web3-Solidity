# Web3-Solidity

# MAPPING
//**mapping** girilen değere göre başka bir değeri döndürmeye yarıyor

mapping(address => uint)  public AccountBalance; // Girilen adresin balance'ını geri döndürüyor. 

mapping(uint => string) UserIdToName // girilen ID'ye sahip kişinin ismini döndürür.

# MSG.SENDER
//**msg.sender** fonksiyonu kullanan kişinin adresini temsil eder

AccountBalance[msg.sender]++; // fonksiyonu çalıştıran kişinin balance'ını 1 arttır.



# REQUİRE
//**require** if gibi çalışır şartı sağlamazsa fonksiyondan çıkar, genellikle o fonksiyonun birden fazla kez çağrılmasını önler

require(ownerZombiCount[msg.sender]==0,"u already have a zombie") // msg.sender'ın 0 tane zombisi varsa çalıştır yoksa metini yazdır.

# STORAGE VE MEMORY
//**Memory bilgiyi** geçici hafızada tutar ve fonksiyon bitince eski değerini geri alır

//**Storage** fonksiyon bitse de aynı değeri tutar aynı ram ve harddisk ilişkisi gibi 

Sandwich storage mySandwich = sandwiches[_index];//mySandwich sandwiches dizisine atılır.
mySandwich.status = "eaten";//mySandwich'in status değeri fonksiyon bitse bile "eaten" olarak kalır.
sandWich memory anotherSandwich = sandwiches[_index++];//anotherSandwich sandwiches dizisine atılır.
anotherSandwich.status = "eaten";//anotherSandwich'in status değeri fonksiyon bitince boş olarak kalır.



# INTERNAL VE EXTERNAL
//**Internal** private ile aynı işlevi görüyor fakat miraslama yapılan contract ile erişilebilir hale getiriyor

//**External** ise public ile aynı işlevi görüyor fakat contract içinden çağrılamıyor sadece dışarıdan çağırılabiliyor

function eat() internal{}
function eat() external{}


# PURE VE VİEW
int num = 10;
//**pure** contratın içindeki herhangi bir değişken kullanılmadığı zaman kullanılır

function add(int x,int y) external pure returns(int){ 
	return x+y;
}

//**view** ise contratın içindeki değişkenler kullanıldığı zaman kullanılır.

function addToNum(int x) external view returns(int){ 
	return x+num;
}
#REVERT VE ASSERT

//**revert** birden fazla şartı sağlamak için genellikle iç içe olan iflerde kullanılır. Fonksiyondan çıkar
if(x<=50){
  //kodlar
  if(x==25){
    revert();
  }	
}

//**assert** gerçekten kötü olabilecek durumlar için kullanılır o yüzden koşulun false olma olasılığı olmamalıdır.

c=a+b;
assert(c>b);

# FUNCTION MODIFIER

//**Basic Modifier** : input almadan fonksiyonların üzerinde değişiklik yapabilmemizi sağlar

modifier whenNotPaused(){
   require(!paused,"paused");
   _;
}

function inc() external whenNotPaused{
   count++;
}

//**Input Modifier** : input alarak fonksiyonlar üzerinde değişiklik yapabilmemizi sağlar

modifier cap(uint _x){
   require(_x<100,"x>=100");
   _;
}

function incBy(uint _x) external cap(_x){
   count+=_x;
}

//**Sandwich Modifier** : Modifier'ın "_;"dan önceki kodları çalışır, sonra main fonksiyon(_;) ,daha sonra "_;"dan sonraki kodlar çalışır

modifier sandwich(){
   count++;
   _;
   count*2;
}

*****************************************************************************************************************

int public minInt=type(int).min; //256 bitlik int veri tipinin minimum sayı değerini verir

int public maxInt=type(int).max; //256 bitlik int veri tipinin maximum sayı değerini verir
