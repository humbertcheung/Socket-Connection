//
//  ViewController.swift
//  Socket-Connection
//
//  Created by HumbertCheung on 2020/4/24.
//  Copyright © 2020 HumbertCheung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // ip地址
    let ipAddrStr = inet_addr("14.215.177.38")
    
    // 端口
    let port = 80
    
    var clientSocket: Int32?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        connetcion(with: port, and: ipAddrStr)
        // 使用了HTTP协议的格式
        let request = "GET / HTTP/1.1\n HOST:www.baidu.com\n\n"
        
        let result = sendAndReceive(by: request)
        
        print("返回的数据是: \(String(describing: result))")
    }
    
    func connetcion(with port: Int, and addr: __uint32_t) {
        
        /*------------------------ 1. 创建socket ------------------------*/
        /*
         参数
         1) domain:     协议域, AF_INET --> IPV4
         2) type:       Socket 类型, SOCK_STREAM(TCP)/SOCK_DGRAM(报文 UDP)
         3) protocol:   IPPROTO_TCP, 如果传入0,会自动根据第二个参数,选择合适的协议
        */

        clientSocket = socket(AF_INET, SOCK_STREAM, 0)

        /*------------------------ 2. 连接到服务器 ------------------------*/
        /*
         参数
         1) 客户端socket
         2) 指向结构体sockaddr的指针，其中包括目的端口和IP地址
         3) 结构体数据长度
         返回值
         0:成功/其他:错误代号
        */
        var serverAddr: sockaddr_in = sockaddr_in()
        // 设置协议域
        serverAddr.sin_family = sa_family_t(AF_INET)
        // 设置端口
        let isLittleEndian = Int(OSHostByteOrder()) == OSLittleEndian
        serverAddr.sin_port = isLittleEndian ? _OSSwapInt16(__uint16_t(port)) : in_port_t(port)
        // 地址
        serverAddr.sin_addr.s_addr = ipAddrStr

        // 此处使用 withUnsafePointer 函数来对 UnsafePointer<sockaddr> 类型的数据进行处理
        withUnsafePointer(to: &serverAddr) {sockaddrInPtr in
            let sockaddrPtr = UnsafeRawPointer(sockaddrInPtr).assumingMemoryBound(to: sockaddr.self)
            let result = connect(clientSocket!, sockaddrPtr, UInt32(MemoryLayout<sockaddr_in>.stride))
            
            if result == 0 {
                print("连接成功")
            } else {
                print("连接失败, ErrCode: \(result)")
            }
        }
    }
    
    func sendAndReceive(by msg: String) -> String {

        /*------------------------ 3. 发送数据给服务器 ------------------------*/
        
        /*
         参数
         1) 客户端socket
         2) 发送的内容
         3) 发送内容的长度
         4) 发送方式标志，一般为0
         返回值
         如果成功，则返回发送的 字节数，失败则返回 SOCKET_ ERROR
        */

        let sendLen = send(clientSocket!, msg, msg.count, 0)
        print("发送内容的长度: \(sendLen)")
        
        /*------------------------ 4. 从服务器接收数据 ------------------------*/
        
        /*
         参数
         1) 客户端socket
         2) 接收内容缓冲区地址
         3) 接收内容缓存区长度
         4) 接收方式，0表示阻塞，必须等待服务器返回数据
         返回值
         如果成功，则返回读入的字节数，失败则返回SOCKET_ ERROR
        */
        // 准备需要存储数据的空间
        var buffer = [UInt8](repeating: 0, count: 1024 * 1024 * 1024)
        
        let recvLen = recv(clientSocket!, &buffer, buffer.count, 0)
        print("接收到的内容长度: \(recvLen)")
        if recvLen < 0 {
            return "未获取到内容"
        }
        
        // 获取传回的数据
        let data = Data(bytes: buffer, count: recvLen)
        
        // 处理数据
        let dataString = String(data: data, encoding: String.Encoding.utf8)
        
        /*------------------------ 5. 关闭 ------------------------*/
        close(clientSocket!)
        return dataString!
    }

}

