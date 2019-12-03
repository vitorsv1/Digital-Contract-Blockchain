pragma solidity ^0.5.1;

contract MyContract {
    uint256 public contractCount = 0;
    mapping(uint => Contract) public contract_;
    address owner;
    
    struct Contract{
        uint _id;
        string contrante;
        string contratado;
        address payable contratante_carteira;
        string descricao;
        string clausula;
        uint multa;
    }
    
    constructor() public{
        owner=msg.sender;
    }
    
    //Função para apenas o contratante poder utilizar
    modifier apenasContratante(){
        require(owner==msg.sender);
        _;
    }
    
    //Realizar a transferencia de carteiras ETH
    function pagarMulta (uint _id, address payable wallet2) public payable{
        if (contract_[_id]._id>0){
            wallet2.transfer(msg.value);
        }
    }
    
    //Verificar se o contrato exist
    function getContractExists(uint256 _id) private view returns(bool){
        if (contract_[_id]._id>0){
            revert("Contrato ja existente!");
        }
        else{return true;}
    }
    
    //Criar um contrato
    function addContract(uint _id, string memory _contrante, string memory _contratado, address payable _contrante_carteira, string memory _descricao, string memory _clausula, uint _multa) public apenasContratante{
        bool contractExists = getContractExists(_id);
        if (contractExists){
            countContract();
            contract_[_id] = Contract(_id, _contrante, _contratado, _contrante_carteira, _descricao,_clausula, _multa);
        }
    }
    
    //Retorna a multa do contrato específico
    function getMulta(uint _id, string memory _clausula) public view returns(uint){
        string memory clausula = contract_[_id].clausula;
        if (compareStrings(clausula, _clausula)){
            return contract_[_id].multa;
        }
    }
    
    //Compara strings para condição
    function compareStrings (string memory a, string memory b) private view returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );
    }
    
    //Conta número de contratos
    function countContract() internal{
        contractCount+=1;
    } 
    
    
}