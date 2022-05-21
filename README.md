# Web3-Solidity

# MAPPING
//**mapping** girilen değere göre başka bir değeri döndürmeye yarıyor

    mapping(address => uint)  public AccountBalance; // Girilen adresin balance'ını geri döndürüyor. 

    mapping(uint => string) UserIdToName // girilen ID'ye sahip kişinin ismini döndürür

# MSG.SENDER
//**msg.sender** fonksiyonu kullanan kişinin adresini temsil eder

    AccountBalance[msg.sender]++; // fonksiyonu çalıştıran kişinin balance'ını 1 arttır.



# REQUİRE
//**require** if gibi çalışır şartı sağlamazsa fonksiyondan çıkar, genellikle o fonksiyonun birden fazla kez çağrılmasını önler.

    require(ownerZombiCount[msg.sender]==0,"u already have a zombie") // msg.sender'ın 0 tane zombisi varsa çalıştır yoksa metini yazdır.

# STORAGE VE MEMORY
//**Memory bilgiyi** geçici hafızada tutar ve fonksiyon bitince eski değerini geri alır

//**Storage** fonksiyon bitse de aynı değeri tutar aynı ram ve harddisk ilişkisi gibi 

    Sandwich storage mySandwich = sandwiches[_index];//mySandwich sandwiches dizisine atılır.
    
    mySandwich.status = "eaten";//mySandwich'in status değeri fonksiyon bitse bile "eaten" olarak kalır.
    
    sandWich memory anotherSandwich = sandwiches[_index++];//anotherSandwich sandwiches dizisine atılır.
    
    anotherSandwich.status = "eaten";//anotherSandwich'in status değeri fonksiyon bitince boş olarak kalır



# INTERNAL VE EXTERNAL
//**Internal** private ile aynı işlevi görüyor fakat miraslama yapılan contract ile erişilebilir hale getiriyor

//**External** ise public ile aynı işlevi görüyor fakat contract içinden çağrılamıyor sadece dışarıdan çağırılabiliyor

    function eat() internal{}
    function eat() external{}


# PURE VE VİEW

//**pure** contratın içindeki herhangi bir değişken kullanılmadığı zaman kullanılır

    int num = 10;
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
       _ ;
    }

    function inc() external whenNotPaused{
       count++;
    }

//**Input Modifier** : input alarak fonksiyonlar üzerinde değişiklik yapabilmemizi sağlar

    modifier cap(uint _x){
       require(_x<100,"x>=100");
       _ ;
    }

    function incBy(uint _x) external cap(_x){
       count+=_x;
    }

//**Sandwich Modifier** : Modifier'ın "_ ;"dan önceki kodları çalışır, sonra main fonksiyon(_ ;) ,daha sonra "_ ;"dan sonraki kodlar çalışır

    modifier sandwich(){
       count++;
       _ ;
       count*2;
    }

# CONSTRUCTOR

//Constructorlar contract deploy edildiğinde ilk başta ve bir kez çağrılır.

    address public owner;

    uint public x;

    constructor(uint _x) {
       owner = msg.sender;
       x=_x;
    }

# Ownable

// Kontratlarda **ownable** kullanılacaksa constructor içinde tanımlanır ve modifier olarak fonksiyonlarda kullanılır

// **onlyOwner** fonksiyonu kullanılan fonksiyonları sadece owner olan adres çağırabilir.

    modifier onlyOwner(){

       require(msg.sender==owner,"you are not the owner");
   
       _;
   
    }

// Yeni **ownerı** belirlemek için de setOwner fonksiyonu kullanılır 

    function setOwner(address _newOwner) external onlyOwner{
    
       require(_newOwner==owner,"Invalid address");
   
       owner=_newOwner;
    }


# Array

//diziler her belirli değerleri içinde tutar ve çağırılmasına göre o değeri geri döndürür.

    uint[] public nums = [1,2,3,4]

    uint[3] public numsFixed = [3,4,5]

    nums.push(5); // [1,2,3,4,5]

    nums[2] = 777; // [1,2,777,4,5]

    delete nums[1]; // 1.değeri siler [1,0,777,4,5]

    nums.pop(); // son değeri diziden çıkarır

    nums.length; // dizinin uzunluğunu verir

## Array Remove

    uint[] public arr;

    function remove(uint _index) public {
        require(_index < arr.length, "index out of bound"); // girdinin dizinin boyutundan büyük olup olmadığına bakıyor

        for (uint i = _index; i < arr.length - 1; i++) {   // silinecek sayıdan sonraki değerleri sondan bir önceki değere kadar bir arttırıyor
	
            arr[i] = arr[i + 1];
        }
        arr.pop();    // son değeri diziden çıkarıyor
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        // [1, 2, 4, 5]
       
    }

# STRUCT

// structlar basitçe herhangi bir nesnenin özelliklerini tutar

        Struct Car{ // Car değerlerini tutan struct

           string model;
   
           uint year;
   
           address owner;
        }

Car memory Mercedes = Car("Mercedes",2020,msg.sender);

//Structlar dizilerde tutulabilir

    Car[] public cars;

    cars.push(Mercedes);

    cars.push("Fiat",2015,msg.sender);

    Car storage _car=cars[0];

    _car.year = 2012;

# Event

//blockchain üzerinde gerçekleşen hareketler transaction yapısına bakarak gözlemlenebilirilgili transaction ile 
birlikte ne yapıldığı bilgisine erişilebilir.Event yapısı ise çok daha hızlı bir şekilde bu bilgiyi bize verebilmektedir.

    event sendMessage(address indexed recipient,string  message);

    function mesaj(string calldata _message) external{

       emit sendMessage(msg.sender,_message);
    }

# Inheritence

// Sözleşmelerin birbirleriyle ilişkili olmasını yani miras alınan sözleşmenin public fonksiyonlarını ve değişkenlerini
kullanabilmemizi sağlar

    contract A{

       uint index;

       function send() public {}

    }    

    contract B is A{   //Contract B'yi deploy edersek A'daki send() ve indexi kullanabiliriz.
	
    }

// Multiple Inheritence aşağıdaki şekilde yapılır ve ilk önce base class(A) yazılır.

    contract C is A, B { }

// Miras alırken diğer contractların constractorlarının inputları aşağıdaki şekillerde tanımlanabilir

    contract C is A("x"), B("y") { }

    contract C is A, B{

       constructor(string memory _name, string memory _text) A(_name) B(_text) {
   
       }    
    }

# Payable

// payable anahtar kelimesi kullanıldığı yere ether gönderebilme ve alabilme işlevi verir.

    address payable public owner;
    
    constructor(){
        owner = payable(msg.sender);
    }
    
    function deposit() public payable {
        
    }
    function balance() public view returns(uint){
        return address(this).balance;
    }
    
    
# Fallback ve Receive
    

//Fallback fonksiyonu çoğunlukla smart contract'ın ether almasını aktif etmek için kullanılır

    fallback() external payable {}

//Receive fonksiyonu fallback ile işlevi görür farkı ise gönderilen veri boş olduğu zaman devreye girer.

    receive() external payable {}
   
# Transfer, Send ve Call

// Üçüde contractlar arasında eth göndermek için kullanılır fakat genellikle Transfer ve Call fonksiyonları tercih edilir.

// Transfer fonksiyonunda alıcı contract içinde fallback veya receive olması gerek yoksa transfer çağrısı hata verir, gas limiti  2300'dür.

    function sendViaTransfer(address payable _to) external payable {
    
    _to.transfer(123);

    }

//Send fonksiyonu Transfer'e benzerdir. Gas limiti 2300'dür. Transfer'den farkı geriye bool döndürür.

    function sendViaSend(address payable _to) external payable {
    
    bool sent = _to.send(123);
    require(sent,"send failed");

    }

//Call fonksiyonu en çok tercih edilendir. Gas limiti yoktur, bool ve veri geri döndürebilir

    function sendViaCall(address payable _to) external payable {
    
    (bool success, ) = _to.call{value : 123}("");
    require(success,"call failed");

    }
 
 # Contract'a Ether Gönderme ve Alma Örneği
 
    contract EtherWallet{

        address payable public owner;
        constructor(){
            owner = payable(msg.sender);
        }
        receive() external payable{}

        function withDraw(uint _amount) external {
            require(msg.sender==owner,"you are not the owner");
            payable(msg.sender).transfer(_amount);
        }
        function getBalance() external view returns(uint){

            return address(this).balance;
        }
    }

# Interface ve Abstract Contractlar

// Abstract contractlar içerilerinde herhangi bir uygulama yapmazlar sadece tanımlama içerirler. içerikleri başka
contractlarda miras alınarak tanımlanır.

    abstract contract Feline {
        function utterance() public virtual returns (bytes32);
    }

    contract Cat is Feline {
        function utterance() public override returns (bytes32) { return "miaow"; }
    }

// Interfaceler abstract contractlara benzerler fakat daha fazla kısıtlamaya sahiptirler.
// Diğer contractlardan miras alamazlar fakat diğer interfacelerden miraslanabilirler
// Bütün tanımlanan fonksiyonları external olmak zorundadır
// İçerisinde constructor ve değişken tanımlanamaz

    interface Token {
        enum TokenType { Fungible, NonFungible }
        struct Coin { string obverse; string reverse; }
        function transfer(address recipient, uint amount) external;
    }

# Call

// Amacımız başka bir contract içerisindeki fonksiyonu çağırarak o contract'a wei göndermek.

    contract Testcall{
    
       fallback() external payable{}

       function foo(string memory _message,uint _x) external payable returns(bool,uint){
     
        return(true,999);
     }
    }
    contract Call{

     function callFoo(address _test) external{
 
     (bool success,bytes memory _data) = _test.call{value:111}(abi.encodeWithSignature("foo(string,uint256)","call foo",123));

     }
    }

# New

// Amacımız AccountFactory contractı ile Account contractına adres gönderip yeni bir hesap kurma işlemi

    Contract Account{

     address public bank;

     address public owner;

     constructor(address _owner) payable {
       
       bank=msg.sender
       owner = _owner;
 
      }
    }

     contract AccountFactory{
 
      Account[] public accounts;
      function createAccount(address _owner) external payable{

        Account account = new Account{value : 111}(_owner);
        accounts.push(account)
      }        

     }
     
# Library

// Library'ler çeşitli işlemleri daha kolay ve güvenli bir şekilde yapmak için kullanılır.

    library Math{

       function Max(uint x,uint y) internal pure returns(uint){
 
          return x>=y ? x : y;
     }
    }

    contract Test{

       function testMax(uint x, uint y) external pure returns(uint){
 
          return Math.Max(x,y);
     }   
    }
 // Library array örneği
 
    library arrayLib{
        function find(uint[] storage arr, uint x) internal view returns(uint){
            for(uint i=0;i<arr.length;i++){
                if(arr[i]==x){
                    return i;
                }
            }
            revert("not found");
        }
    }

    contract CallTestContract{

    using arrayLib for uint[];
    uint[] public arr = [1,2,3];
   
    function Testarray() external view returns(uint) {
        
        return arr.find(2);

     }
   
    }
    
# Hash

// Hash fonksiyonu herhangi bir girdi alır ve karşılığında eşsiz bir çıktı verir.

     function Hash(string memory text,uint num,address addr) external pure returns(bytes32){

        return keccak256(abi.encodePacked(text,num,addr));
     }

// encode ve encodePacked arasındaki fark encodepacked'in çıktısı encode'a göre daha basittir
     
     function encode(string memory text0,string memory text1) external pure returns(bytes memory){

         return abi.encode(text0,text1);
     }
     function encodePacked(string memory text0,string memory text1) external pure returns(bytes memory){

         return abi.encodePacked(text0,text1);
	 
	 }
   
# Access Control

// Admin tarafından giriş izni verilebilir, izin geri alınabilir.

|[Access Control](AccessControl.sol)|

# HelloWorldBank

// Contract'a deposit ile eth aktarılabilir, Withdraw ve Withdrawall fonksiyonu ile geri çekilebilir bir banka uygulaması.

|[HelloWorld_Bank](HelloWorld_Bank.sol)|


*****************************************************************************************************************

    int public minInt=type(int).min; //256 bitlik int veri tipinin minimum sayı değerini verir

    int public maxInt=type(int).max; //256 bitlik int veri tipinin maximum sayı değerini verir
