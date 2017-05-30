package com.aquent.crudapp.service;

import java.util.List;

import com.aquent.crudapp.domain.Client;
import java.util.Map;

/**
 * Client operations.
 */
public interface ClientService {

    /**
     * Retrieves all of the client records.
     *
     * @return list of client records
     */
    List<Client> listClients();
	
	/**
	 * Gets a Map of valid clients suitable for 
	 * using as a source for a form:select itemlist tag..
	 * i.e. key is clientId, value is client name
	 * @return a map of client id, client name 
	 */
	Map<String,String> clientSelectItemsMap();
			
    /**
     * Creates a new client record.
     *
     * @param client the values to save
     * @return the new client ID
     */
    Integer createClient(Client client);

    /**
     * Retrieves a client record by ID.
     *
     * @param id the client ID
     * @return the client record
     */
    Client readClient(Integer id);

    /**
     * Updates an existing client record.
     *
     * @param client the new values to save
     */
    void updateClient(Client client);

    /**
     * Deletes a client record by ID.
     *
     * @param id the client ID
     */
    void deleteClient(Integer id);

    /**
     * Validates populated client data.
     *
     * @param client the values to validate
     * @return list of error messages
     */
    List<String> validateClient(Client client);
}
