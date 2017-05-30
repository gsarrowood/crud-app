package com.aquent.crudapp.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.aquent.crudapp.data.dao.ClientDao;
import com.aquent.crudapp.domain.Client;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Default implementation of {@link ClientService}.
 */
public class DefaultClentService implements ClientService {

    private ClientDao clientDao;
    private Validator validator;

    public void setClientDao(ClientDao clientDao) {
        this.clientDao = clientDao;
    }

    public void setValidator(Validator validator) {
        this.validator = validator;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<Client> listClients() {
        return clientDao.listClients();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Client readClient(Integer id) {
        return clientDao.readClient(id);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
    public Integer createClient(Client client) {
        return clientDao.createClient(client);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
    public void updateClient(Client client) {
        clientDao.updateClient(client);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
    public void deleteClient(Integer id) {
        clientDao.deleteClient(id);
    }

    @Override
    public List<String> validateClient(Client client) {
        Set<ConstraintViolation<Client>> violations = validator.validate(client);
        List<String> errors = new ArrayList<String>(violations.size());
        for (ConstraintViolation<Client> violation : violations) {
            errors.add(violation.getMessage());
        }
        Collections.sort(errors);
        return errors;
    }

	@Override
	@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
	public Map<String, String> clientSelectItemsMap()
		{
		// use linked hashmap to keep the order in the order they 
		// were inserted.  Order is controlled by the orderby in the
		// select in listClients(), which is by client name and that's 
		// what we want here.
		LinkedHashMap<String, String> clientMap = new LinkedHashMap<>();
		// get the data from the db.
		List<Client> listOfClients = clientDao.listClients();
		// insert a default NONE (-1)
		clientMap.put( "-1","None");
		for (Client c : listOfClients)
			{
			// convert Integer key to String key since select item expects a string.
			clientMap.put( c.getClientId().toString(), c.getName());
			}

		return clientMap;
		}
	
	
}
