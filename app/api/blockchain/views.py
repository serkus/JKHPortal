# coding=utf-8
from uuid import uuid4
from flask import Blueprint, jsonify, request

from app.services.BlockChein.classes import Blockchain

blockchain = Blueprint("blockchain", __name__)

# Генерируем уникальный на глобальном уровне адрес для этого узла
node_identifier = str(uuid4()).replace('-', '')

# Создаем экземпляр блокчейна
blockchainModel = Blockchain()


@blockchain.route('/mine', methods=['GET'])
def mine():
    # Мы запускаем алгоритм подтверждения работы, чтобы получить следующее подтверждение…
    last_block = blockchainModel.last_block
    last_proof = last_block['proof']
    proof = blockchainModel.proof_of_work(last_proof)

    # Мы должны получить вознаграждение за найденное подтверждение
    # Отправитель “0” означает, что узел заработал крипто-монету
    blockchainModel.new_transaction(
        sender="0",
        recipient=node_identifier,
        amount=1,
    )

    # Создаем новый блок, путем внесения его в цепь
    previous_hash = blockchainModel.hash(last_block)
    block = blockchainModel.new_block(proof, previous_hash)

    response = {
        'message': "New Block Forged",
        'index': block['index'],
        'transactions': block['transactions'],
        'proof': block['proof'],
        'previous_hash': block['previous_hash'],
    }
    return jsonify(response), 200

@blockchain.route('/transactions/new', methods=['POST'])
def new_transaction():
    values = request.get_json()

    # Убедитесь в том, что необходимые поля находятся среди POST-данных
    required = ['sender', 'recipient', 'amount']
    if not all(k in values for k in required):
        return 'Missing values', 400

    # Создание новой транзакции
    index = blockchainModel.new_transaction(values['sender'], values['recipient'], values['amount'])

    response = {'message': 'Transaction will be added to Block {index}'.format(index=index)}
    return jsonify(response), 201


@blockchain.route('/chain', methods=['GET'])
def full_chain():
    response = {
        'chain': blockchainModel.chain,
        'length': len(blockchainModel.chain),
    }
    return jsonify(response), 200