# Web3-Solidity

# MAPPING
//mapping girilen değere göre başka bir değeri döndürmeye yarıyor

mapping(address => uint)  public AccountBalance; // Girilen adresin balance'ını geri döndürüyor. 

mapping(uint => string) UserIdToName // girilen ID'ye sahip kişinin ismini döndürür.

# MSG.SENDER
//msg.sender fonksiyonu kullanan kişinin adresini temsil eder

AccountBalance[msg.sender]++;// fonksiyonu çalıştıran kişinin balance'ını 1 arttır.



# REQUİRE
//require if gibi çalışır genellikle o fonksiyonun birden fazla kez çağrılmasını önler

require(ownerZombiCount[msg.sender]==0) // msg.sender'ın 0 tane zombisi varsa çalıştır anlamına gelir

# STORAGE VE MEMORY
//memory bilgiyi geçici hafızada tutar ve fonksiyon bitince eski değerini geri alır

//fakat storage fonksiyon bitse de aynı değeri tutar aynı ram ve harddisk ilişkisi gibi 

Sandwich storage mySandwich = sandwiches[_index];//mySandwich sandwiches dizisine atılır.
mySandwich.status = "eaten";//mySandwich'in status değeri fonksiyon bitse bile "eaten" olarak kalır.
sandWich memory anotherSandwich = sandwiches[_index++];//anotherSandwich sandwiches dizisine atılır.
anotherSandwich.status = "eaten";//anotherSandwich'in status değeri fonksiyon bitince boş olarak kalır.



# INTERNAL VE EXTERNAL
//internal private ile aynı işlevi görüyor fakat miraslama yapılan contract ile erişilebilir hale getiriyor

//External ise public ile aynı işlevi görüyor fakat contract içinden çağrılamıyor sadece dışarıdan çağırılabiliyor

function eat() internal{}
function eat() external{}


# PURE VE VİEW
int num = 10;

function add(int x,int y) external pure returns(int){ // pure contratın içindeki herhangi bir değişken kullanılmadığı zaman kullanılır
	return x+y;
}
function addToNum(int x) external view returns(int){ // view ise contratın içindeki değişkenler kullanıldığı zaman kullanılır.
	return x+num;
}


*****************************************************************************************************************

int public minInt=type(int).min; //256 bitlik int veri tipinin minimum sayı değerini verir
int public maxInt=type(int).max; //256 bitlik int veri tipinin maximum sayı değerini verir
