import React from 'react'


export default function NFTCard({nft}:any) {

    const cardStyles = {
        boxShadow:  "rgba(100,100,111,0.2) 0px 7px 29px 0px",
        minHeight:"400px",
        minwidth:"250px",
        maxwidth:"400px",
        margin:"10px",
        padding: "10px",



    }

    const imageStyles={
        width:"60%",
        height:"50%",
    }

    return <div style={cardStyles}>
    <div style={{
        display: "flex",
        justifyContent: "center",
        alignItems: "center"
    }}>
    <img src={nft.metadata.image}></img>
    <div>
        <p>{nft.title}</p>
        <p>{nft.description}</p>
        {nft.metadata.attributes.map((item:any,index:number) =><span style={{
            padding:"4px",
            borderRadius:"10px",
            background: "black",
            color:"white",
            border:"none",
            margin:"2px 4px",
        }} key={index}>{item.trait_type}:{item.value}</span>)}
        <p></p>

    </div>
    </div>
    
    </div>;
        
    
}

