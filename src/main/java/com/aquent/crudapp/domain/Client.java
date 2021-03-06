package com.aquent.crudapp.domain;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * The Client entity corresponding to the "client" table in the database.
 */
public class Client {
    private Integer clientId;

    @NotNull
    @Size(min = 1, max = 50, message = "Client name is required with maximum length of 50")
    private String name;

    @NotNull
    @Size(min = 1, max = 50, message = "Website is required with maximum length of 50")
    private String web;

    @NotNull
    @Size(min = 1, max = 50, message = "Street address is required with maximum length of 50")
    private String addr;

    @NotNull
    @Size(min = 1, max = 50, message = "City is required with maximum length of 50")
    private String city;

    @NotNull
    @Size(min = 2, max = 2, message = "State is required with length 2")
    private String state;

    @NotNull
    @Size(min = 5, max = 5, message = "Zip code is required with length 5")
    private String zipCode;

	public Integer getClientId()
		{
		return clientId;
		}

	public void setClientId(Integer clientId)
		{
		this.clientId = clientId;
		}

	public String getName()
		{
		return name;
		}

	public void setName(String name)
		{
		this.name = name;
		}

	public String getWeb()
		{
		return web;
		}

	public void setWeb(String web)
		{
		this.web = web;
		}

	public String getAddr()
		{
		return addr;
		}

	public void setAddr(String addr)
		{
		this.addr = addr;
		}

	public String getCity()
		{
		return city;
		}

	public void setCity(String city)
		{
		this.city = city;
		}

	public String getState()
		{
		return state;
		}

	public void setState(String state)
		{
		this.state = state;
		}

	public String getZipCode()
		{
		return zipCode;
		}

	public void setZipCode(String zipCode)
		{
		this.zipCode = zipCode;
		}

	
}
